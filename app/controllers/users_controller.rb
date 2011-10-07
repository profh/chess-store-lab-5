class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:update]    
  
  def index
    raise ActiveRecord::RecordNotFound unless current_user && current_user.is_admin?
    @users = User.find_all_by_session_id(session[:session_id])
    
    if current_user.username == 'admin'
      flash.now[:notice] = "Congratulations! You've hacked the default admin account. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('hackedadmin')}</strong></p>".html_safe
    elsif current_user.username == 'gruberman'
      flash.now[:notice] = "Congratulations! You've promoted Ed to an admin. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('boottothehead')}</strong></p>".html_safe
    else
      flash.now[:notice] = "Congratulations! You've promoted to an admin. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('promotedtoadmin')}</strong></p>".html_safe
    end
  end
  
  def show
    # if current_user.username == 'mheimann' && current_user.password == 'ilovegod'
    #   flash.now[:notice] = "Congratulations! You've hacked into Mark Heimann's account. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('ilovegod')}</strong></p>".html_safe
    # elsif current_user.username == 'mheimann' && current_user.changer == 'gruberman'
    #   flash.now[:notice] = "Congratulations! You've changed Mark's password from another account. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('changedpswd')}</strong></p>".html_safe
    # elsif current_user.username == 'lheimann'
    #   flash.now[:notice] = "Oops! You've gotten into Prof. H's account. Well, write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('ohcaptainmycaptain')}</strong></p>".html_safe
    # elsif current_user.password == '1q2w3e'
    #   coded_msg = "#{current_user.username}"
    #   flash.now[:notice] = "Congratulations! You've hacked into an existing account. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64(coded_msg)}</strong></p>".html_safe
    # elsif current_user.username == 'gruberman' && current_user.is_admin?
    #   flash.now[:notice] = "Congratulations! You've promoted Ed to an admin. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('boottothehead')}</strong></p>".html_safe
    # end
    @user = User.find_by_id_and_session_id!(params[:id], session[:session_id])
    raise ActiveRecord::RecordNotFound unless current_user && (current_user.is_admin? || current_user == @user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.session_id = session[:session_id]
    @user.first_name = user_sanitize(@user.first_name)
    @user.last_name = user_sanitize(@user.last_name)
    @user.username = user_sanitize(@user.username)
    @user.password = user_sanitize(@user.password)
    @user.password_confirmation = user_sanitize(@user.password_confirmation)
    
    if @user.save
      session[:user_id] = @user.id
      
      if @user.is_admin?
        redirect_to users_path(session[:session_secret])
      else
        redirect_to user_path(session[:session_secret], @user)
      end
    else
      flash.now[:alert] = @user.errors.full_messages
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find_by_id_and_session_id!(params[:id], session[:session_id])
    raise ActiveRecord::RecordNotFound unless current_user && (current_user.is_admin? || current_user == @user)
  end
  
  def change_password
    @user = User.find_by_id_and_session_id!(params[:id], session[:session_id])
    raise ActiveRecord::RecordNotFound unless current_user && (current_user.is_admin? || current_user == @user)
  end
  
  def update
    if params[:user][:user_id]
      @user = User.find_by_id_and_session_id!(params[:user][:user_id], session[:session_id])
    else
      @user = User.find_by_id_and_session_id!(params[:id], session[:session_id])
    end
    
    
    if params[:user][:user_id]
      @user.id = params[:user][:user_id]
      @user.password = params[:user][:password]
      @user.changer = params[:user][:changer]
      if @user.save!
        flash[:notice] = 'Your password was changed!'
      else
        flash[:alert] = 'Your password could not be changed.'
      end
    elsif @user.update_attributes(params[:user])
      if !current_user || current_user != @user
        flash[:notice] = "Congratulations! You've successfully executed a CSRF. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('completedCSRF')}</strong></p>"
      else
        flash[:notice] = 'Your account was updated!'
      end
    else
      flash[:alert] = @user.errors.full_messages
    end
    redirect_to user_path(session[:session_secret], @user)
  end
  
  def destroy
    @user = User.find_by_id_and_session_id!(params[:id], session[:session_id])
    if !current_user || current_user != @user
      flash[:notice] = "Congratulations! You've successfully found a backdoor for delete accounts. Write down the following code so we know you've reached this page: <p align=\"center\"><strong>#{Base64.encode64('foundbackdoor')}</strong></p>"
    end

    @user.destroy
    redirect_to store_path
  end
end