class AdminsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_admin, only: [:edit, :update]

  before_action :set_admin

  def update
    if @admin.update_attributes(admin_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to root_path, flash: flash
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email, :password,
                                  :password_confirmation)
  end

  # Confirms a logged-in user.
  def logged_in_admin
    unless admin_logged_in?
      # store_location
      redirect_to root_url, flash: {danger: '请先以管理者身份登录'}
    end
  end

  def set_admin
    @admin = Admin.find_by_id(params[:id])
  end

end
