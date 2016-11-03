class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in, only: :update
  before_action :correct_user, only: :update
  before_action :admin_logged_in, only: [:admin_update, :index, :destroy, :admin_create]

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

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to root_path, flash: flash
  end

  # -------------------------------------- admin

  def index
    @users=User.none_hidden_users.paginate(:page => params[:users_page], :per_page => 10)
    if !params[:user_id].blank?
      @user=User.find_by(id: params[:user_id].to_i)
    end
  end

  def admin_new
    @user=User.new
  end

  def admin_update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end

    if @user.id!=current_user.id
      if params[:user][:admin]=="管理员"
        @user.update_attribute(:admin, true)
      elsif params[:user][:admin]=="普通"
        @user.update_attribute(:admin, false)
      end
    end
    redirect_to users_path, flash: flash
  end

  def admin_create
    @user = User.new(user_params)
    @user.admin=true if params[:user][:admin]=="管理员"
    @user.admin=false if params[:user][:admin]=="普通"
    if @user.save
      redirect_to users_path, flash: {:info => "创建成功"}
    else
      flash[:warning]= "创建失败"
      render 'admin_new'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to users_path(user_new: false), flash: {success: "用户删除"}
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

  def admin_logged_in
    unless admin?(current_user)
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


end
