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
    #@commments = @video.comments.find_all_by_status('accepted')
    @comments = Comment.find_all_by_video_id_and_status(id,'accepted')
    if @comments == nil
      @comments = []
    end
  end

  def new
    render :layout => 'videos'
  end

  def create
    name, email, age = params[:name], params[:email], params[:age]
    ethnicity = params[:ethnicity]
    language, location = params[:language], params[:location]
    title, about = params[:title], params[:about]
    why, how, hope = params[:why], params[:how], params[:hope]
    video = params[:video]
    if (name != '' and email != '' and age != '' and ethnicity != nil and
        language != '' and location != '' and title != '' and about != '' and
        video != nil)
      spawn_block(:kill => true) do
        video_hash = {:video => File.new(video.path), :title => 'Title', :description => why}
        yt_id = Video.upload(video_hash)
        # Fix this to support user id/login
        video = Video.new(:youtube_id => yt_id, :user_id => '', :name => name,
                          :email => email, :age => age, :ethnicity => ethnicity.keys,
                          :language => language, :location => location,
                          :title => title, :about => about,
                          :why => why, :how => how, :hope => hope,
                          :status => 'pending', :likes => 0)
        video.save!
      end
      reset_db_connection_post_fork
      flash[:notice] = 'Thank you for your submission! We will be reviewing your story soon!'
      redirect_to videos_path
    else
      flash[:error] = 'Please fill in all missing fields'
      redirect_to new_video_path
    end
  end

  def search
    @search_condition = Video::SEARCH_OPTIONS.include?(params[:search_condition]) ? params[:search_condition] : nil

    if params[:search_condition].blank? || params[:search_condition] == "Title" || !Video::SEARCH_OPTIONS.include?(params[:search_condition])
      params[:search_condition] = "Name"
    end
    @videos = Video.search(params[:search_text], params[:search_condition]).page(params[:page]).per(5)
    @search_text = params[:search_text]
  end

  def like
    id = params[:id]
    @video = Video.find_by_id(id)
    if not(@video)
      flash[:error] = 'Invalid video id'
      redirect_to videos_path
    end

    @video.likes += 1
    @video.save!

    flash[:notice] = 'Thank you for your like!'

    redirect_to video_path(@video)
  end

  def create_comment
    video_id = params[:id]
    content = params[:content]
    anonymous = params[:anonymous]
    user = current_user

    video = Video.find(video_id)

    if user != nil
      user_id = user.id
    else
      user_id = -1
    end

    if (content != '' and video_id != '' and user_id != '')
      comment = Comment.new(:content => content, :video_id => video_id,
                            :user_id => user_id, :status => 'pending',
                            :anonymous => anonymous)
      if comment != nil
        comment.save!
      end
      flash[:notice] = 'Thank you for your comment! We will be reviewing it soon!'
    else
      flash[:error] = 'Please fill in a comment'
    end
    redirect_to video_path(video)
  end

  def reset_db_connection_post_fork
    ActiveRecord::Base.establish_connection
  end

end
