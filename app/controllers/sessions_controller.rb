class SessionsController < ApplicationController
  include SessionsHelper

  def create_admin
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
      admin_log_in admin
      params[:session][:remember_me] == '1' ? remember_admin(admin) : forget_admin(admin)
       flash= {:info => "欢迎登录: #{admin.name} :)"}
    else
      flash= { :danger => '账号或密码错误' }
    end
      redirect_to root_url(login_role: 'admin'), :flash =>flash
  end

  def destroy_admin
    admin_log_out if admin_logged_in?
    redirect_to root_url
  end

end
