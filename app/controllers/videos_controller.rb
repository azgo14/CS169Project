class VideosController < ApplicationController

# RESTful routes reference
# GET    /items        #=> index
# GET    /items/1      #=> show
# GET    /items/new    #=> new
# GET    /items/1/edit #=> edit
# PUT    /items/1      #=> update
# POST   /items        #=> create
# DELETE /items/1      #=> destroy

  def index
  end

  def show
  end

  def new
    render :layout => 'videos'
  end

  def create
    dev_key = 'AI39si6KxFUeYAkWUV5FVWzUThnJGb6PmeSdXOBa9MeKapONiggor24t22qsWmgRGzzWZuaqdQeeMVF8XBaWFDi-_XPgOayKLg'
    username = 'testacct281'
    password = 'testpass281'
    client = YouTubeIt::Client.new(:dev_key => dev_key,
                                   :username => username,
                                   :password => password)
    response = client.video_upload(File.open(params[:video].path), :title => 'test',
                                   :description => 'desc', :comment => 'denied')
    video = Video.new(:youtube_id => response.video_id)
    video.save!
    flash[:notice] = 'Video uploaded!'
    redirect_to new_video_path
  end

end
