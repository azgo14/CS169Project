class Admin::VideosController < ApplicationController
  before_filter :authenticate_admin

  def index
    @pending_videos = Video.pending_videos
    @accepted_videos = Video.accepted_videos
    @rejected_videos = Video.rejected_videos
  end

  def show
    id = params[:id]
    @video = Video.find_by_id(id)
    @comments = Comment.find_all_by_video_id(id)
  end

  def update
    @video = Video.find_by_id(params[:id])
    @video.update_attributes!(params[:video])
    flash[:notice] = 'This video has been successfully updated.'
    redirect_to :back
  end

  def accept
    @video = Video.find_by_id(params[:id])
    @video.update_attributes(:status => :accepted)
    # Make this publicly list videos on Youtube
    # @video.make_listed
    SubmissionMailer.submission_accepted(@video).deliver
    flash[:notice] = 'This video has been accepted.'
    redirect_to :back
  end

  def reject
    @video = Video.find_by_id(params[:id])
    @video.update_attributes(:status => :rejected)
    # Make this unlist videos on Youtube
    # @video.make_unlisted
    flash[:notice] = 'This video has been rejected.'
    redirect_to :back
  end
end
