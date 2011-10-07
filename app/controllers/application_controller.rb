class ApplicationController < ActionController::Base
  # ensure people are sandboxed to their environment
  before_filter :sandbox

  include CustomAuth
  protect_from_forgery
  before_filter :do_level
  
  private
  def sandbox
    cookies[:session_id] ||= Base64.encode64("#{request.remote_ip}").chomp
    if !session[:session_secret]
      session[:session_secret] = SecureRandom.hex(12)
      DB::reset(session[:session_id])
    end

    return redirect_to "/#{session[:session_secret]}" if !params[:session_secret]
    return render :text => 'Invalid session secret!', :status => 500 if params[:session_secret] != session[:session_secret]
  end
  
  # none = 0
  # easy = 1
  # medium = 2
  # difficult = anything else
  def do_level
    level = session[:level] ||= 0
    text = %w(None Low Medium)[level] || 'High'
    
    # this is probably a security risk in itself :)
    class_eval("include Levels::#{text}")
  end
end