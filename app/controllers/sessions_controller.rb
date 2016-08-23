class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash= {:info => "欢迎登录: #{user.name} :)"}
    else
      flash= {:danger => '账号或密码错误'}
    end
    redirect_to root_url, :flash => flash
  end

  def visit
    mapping_db=MappingDb.find_by(auth_token: params[:session][:auth_token])
    if mapping_db
      login_visit mapping_db
      flash= {:info => "欢迎登录: #{mapping_db.supplier1} :)"}
    else
      flash= {:danger => '授权码有误,请联系管理员'}
    end
    redirect_to root_path, :flash => flash
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def destroy_visit
    log_out_visit if logged_in_visit?
    redirect_to root_url
  end



end
