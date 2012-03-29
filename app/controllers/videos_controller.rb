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
    response = yt_client.video_upload(File.open(params[:video].path), :title => 'test',
                                      :description => 'desc', :comment => 'denied')
    video = Video.new(:youtube_id => response.video_id[response.video_id.rindex(':')+1..-1])
    video.save!
    flash[:notice] = 'Video uploaded!'
    redirect_to new_video_path
  end

end
