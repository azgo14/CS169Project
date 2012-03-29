class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:dev_key => 'AI39si6KxFUeYAkWUV5FVWzUThnJGb6PmeSdXOBa9MeKapONiggor24t22qsWmgRGzzWZuaqdQeeMVF8XBaWFDi-_XPgOayKLg', :username => 'testacct281', :password => 'testpass281')
  end
end
