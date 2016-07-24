module SessionsHelper

  def admin_log_in(admin)
    session[:admin_id] = admin.id
  end

  def admin_logged_in?
    !current_admin.nil?
  end

  # 点击log_out,安全退出.只关闭浏览器时会保存cookie,安全退出后就没有了
  def admin_log_out
    forget_admin(current_admin)
    session.delete(:admin_id)
    @current_admin = nil
  end

  # Returns the user corresponding to the remember token cookie.
  def current_admin
    if session[:admin_id]
      @current_admin||= Admin.find_by(id: session[:admin_id])
    elsif cookies.signed[:admin_id]
      admin = Admin.find_by(id: cookies.signed[:admin_id])
      if admin && admin.admin_authenticated?(:remember, cookies[:remember_token])
        admin_log_in admin
        @current_admin = admin
      end
    end
  end

  def remember_admin(admin)
    admin.admin_remember
    # Because it places the id as plain text, this method exposes the form of the application’s cookies
    # and makes it easier for an attacker to compromise user accounts. To avoid this problem,
    # we’ll use a signed cookie, which securely encrypts the cookie before placing it on the browser:
    cookies.signed[:admin_id] = {value: admin.id, expires: 1.years.from_now.utc}
    cookies[:remember_token] = {value: admin.remember_token, expires: 1.years.from_now.utc}
  end

  def forget_admin(admin)
    admin.admin_forget
    cookies.delete(:admin_id)
    cookies.delete(:remember_token)
  end

  def current_admin?(admin)
    admin == current_admin
  end

end
