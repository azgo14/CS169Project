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
    name, email, age = params[:name], params[:email], params[:age]
    ethnicity = params[:ethnicity]
    language, location = params[:language], params[:location]
    why, how, hope = params[:why], params[:how], params[:hope]
    video, release = params[:video], params[:release]
    if (name != '' and email != '' and age != '' and ethnicity != nil and
        language != '' and location != '' and why != '' and how != '' and
        hope != '' and video != nil and release == 'true')
      begin
        response = yt_client.video_upload(File.open(video.path), :title => 'test',
                                          :description => 'desc', :comment => 'denied',
                                          :private => '')
        yt_id = response.video_id[response.video_id.rindex(':')+1..-1]
      rescue Exception
        yt_id = ''
      end
      # Fix to support user id/login
      video = Video.new(:youtube_id => yt_id, :user_id => '', :name => name,
                        :email => email, :age => age, :ethnicity => ethnicity.keys,
                        :language => language, :location => location,
                        :why => why, :how => how, :hope => hope, :qa => '',
                        :status => 'pending')
      video.save!
      flash[:notice] = 'Video uploaded!'
      redirect_to videos_path
    else
      flash[:error] = 'Please fill in all missing fields'
      redirect_to new_video_path
    end
  end

end
