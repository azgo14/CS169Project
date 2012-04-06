class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def authenticate_admin
    unless current_user.try(:admin?)
      flash[:error] = "You must be an Admin to view this"
      redirect_to root_path
    end
  end
  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:dev_key => 'AI39si6KxFUeYAkWUV5FVWzUThnJGb6PmeSdXOBa9MeKapONiggor24t22qsWmgRGzzWZuaqdQeeMVF8XBaWFDi-_XPgOayKLg', :username => 'testacct281', :password => 'testpass281')
  end
end
