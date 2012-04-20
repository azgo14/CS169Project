class Admin::VideosController < ApplicationController
  before_filter :authenticate_admin

  def index
    @pending_videos = Video.pending_videos
    @accepted_videos = Video.accepted_videos
    @rejected_videos = Video.rejected_videos
  end

  def show
    @video = Video.find_by_id(params[:id])
  end

  def update
    @video = Video.find_by_id(params[:id])
    @video.update_attributes!(params[:video])
    flash[:notice] = 'This video has been successfully updated.'
    redirect_to admin_video_path(@video)
  end

  def accept
    @video = Video.find_by_id(params[:id])
    @video.update_attributes(:status => :accepted)
    # Make this publicly list videos on Youtube
    # @video.make_listed
    flash[:notice] = 'This video has been accepted.'
    redirect_to admin_video_path(@video)
  end

  def reject
    @video = Video.find_by_id(params[:id])
    @video.update_attributes(:status => :rejected)
    # Make this unlist videos on Youtube
    # @video.make_unlisted
    flash[:notice] = 'This video has been rejected.'
    redirect_to admin_video_path(@video)
  end

#  def pend
#    @video = Video.find_by_id(params[:id])
#    @video.update_attributes(:status => :pending)
#    # Make ths unlist videos on Youtube
#    # @video.make_unlisted
#    redirect_to admin_video_path(@video)
#  end
end
