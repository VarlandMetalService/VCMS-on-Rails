class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  before_filter :require_login
  
  include SessionsHelper
  
protected

  def require_permission(right, level)
    @access_level ||= current_user.permissions.find_by_permission right
    if @access_level.nil? || @access_level.access_level < level
      redirect_to(root_url, flash: { error: 'Permission denied. Please contact IT if you have questions.' }) and return
    end
  end

  def require_login
    unless logged_in?
      redirect_to(login_url) and return
    end
  end
  
end