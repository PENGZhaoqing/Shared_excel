class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in, except: [:new, :create]
  # before_action :correct_user, except: [:new, :create,:dashboard]
  before_action :set_user

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, flash: {success: "新账号注册成功,请登陆"}
    else
      flash[:warning] = "账号信息填写有误,请重试"
      render 'new'
    end
  end

  def index
    @new_users=User.new_users(true).paginate(:page => params[:new_users_page], :per_page => 10)
    @users=User.new_users(false).paginate(:page => params[:users_page], :per_page => 10)
    if !params[:user_id].blank?
      @user=User.find_by(id: params[:user_id].to_i)
    end
  end


  def update
    if @user.update_attributes(user_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end

    if admin?(current_user) && @user.id!=current_user.id
      @user.update_attribute(:new, false)
      @user.update_attribute(:role, params[:user][:role])
      redirect_to users_path(new: false), flash: flash
    else
      redirect_to root_path, flash: flash
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path(new: false), flash: {success: "用户删除"}
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :company, :password,
                                 :password_confirmation)
  end


  # Confirms a logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end


  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_url, flash: {:warning => '此操作需要管理员身份'}
    end
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end

end
