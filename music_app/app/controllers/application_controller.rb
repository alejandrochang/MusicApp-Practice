class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :log_in_user!

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
     # reset after each login
  end

  def current_user
    # return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
    # if no current user find the user by session_token
  end

  def logged_in?
    !!current_user # return true or false whether user is logged in
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
