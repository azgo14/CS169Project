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

  def accept
    @video = Video.find_by_id(params[:id])
    @video.update_attributes(:status => :accepted)
    redirect_to admin_videos_path
  end

  def reject
    @video = Video.find_by_id(params[:id])
    @video.update_attributes(:status => :rejected)
    redirect_to admin_videos_path
  end

  def pend
    @video = Video.find_by_id(params[:id])
    @video.update_attributes(:status => :pending)
    redirect_to admin_videos_path
  end
end
