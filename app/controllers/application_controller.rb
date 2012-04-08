class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  #this method is used in order to remember where to return to when loging in.
  def custom_user_sign_in
    if current_user.nil?
      session[:return_location] = request.referrer
      redirect_to new_user_session_path
    else
      redirect_to request.referrer || root_path
    end
  end

  private
  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  #this is so logout takes you back to the page you were on
  def after_sign_out_path_for(resource_or_scope)
    request.referrer || root_path
  end

  #if custom return_location is specified, then redirect to that path
  def after_sign_in_path_for(resource_or_scope)
    if !session[:return_location].nil?
      return_location = session[:return_location]
      session[:return_location] = nil
    end
    return_location || stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
  end

  def authenticate_admin
    unless current_user.try(:admin?)
      flash[:error] = "You must be an Admin to view this"
      if current_user.nil?
        authenticate_user!
      else
        redirect_to root_path
      end
    end
  end
  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:dev_key => 'AI39si6KxFUeYAkWUV5FVWzUThnJGb6PmeSdXOBa9MeKapONiggor24t22qsWmgRGzzWZuaqdQeeMVF8XBaWFDi-_XPgOayKLg', :username => 'testacct281', :password => 'testpass281')
  end
end
