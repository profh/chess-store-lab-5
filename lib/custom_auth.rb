module CustomAuth
  def self.included(controller)
    controller.send :helper_method, :current_user, :logged_in?
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= nil
    end
  end
  
  def logged_in?
    current_user != nil
  end
  
  def require_logged_in
    unless logged_in?
      session[:return_to] = request.url
      redirect_to login_url, :alert => 'You must be logged in to perform that action'
    end
  end
  
  def redirect_if_logged_in
    redirect_to :back, :notice => 'You are already logged in' if logged_in?
  end
end