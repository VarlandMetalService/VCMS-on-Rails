class SessionsController < ApplicationController
  
  skip_before_filter :require_login, :only => [:create, :new]
  
  def new
    render :layout => false
  end
  
  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Authentication failed. Please try again or contact IT for help.'
      render 'new', :layout => false
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end