class VideosController < ApplicationController

# RESTful routes reference
# GET    /items        #=> index
# GET    /items/1      #=> show
# GET    /items/new    #=> new
# GET    /items/1/edit #=> edit
# PUT    /items/1      #=> update
# POST   /items        #=> create
# DELETE /items/1      #=> destroy
  before_filter :authenticate_user!, :only => [:new, :create]
  def index
    @videos = Video.accepted_videos
  end

  def show
    id = params[:id]
    @video = Video.find_by_id(id)
    if not(@video)
      flash[:error] = 'Invalid video id'
      redirect_to videos_path
    end
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
      video_hash = {:video => File.new(video.path), :title => 'Title', :description => why}
      yt_id = Video.upload(video_hash)
      # Fix this to support user id/login
      video = Video.new(:youtube_id => yt_id, :user_id => '', :name => name,
                        :email => email, :age => age, :ethnicity => ethnicity.keys,
                        :language => language, :location => location,
                        :why => why, :how => how, :hope => hope, :qa => '',
                        :status => 'pending')
      video.save!
      flash[:notice] = 'Thank you for your submission! We will be reviewing your story soon!'
      redirect_to videos_path
    else
      flash[:error] = 'Please fill in all missing fields'
      redirect_to new_video_path
    end
  end
  def search
    if params[:search_condition].blank? || params[:search_condition] == "Title"
      params[:search_condition] = "Name"
    end
    @videos = Video.search(params[:search_text], params[:search_condition])
    @search_text = params[:search_text]
    @search_condition = params[:search_condition]
  end
end
