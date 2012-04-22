class Admin::CommentsController < ApplicationController
  before_filter :authenticate_admin

  def index
    @pending_comments = Comment.pending_comments
    @accepted_comments = Comment.accepted_comments
    @rejected_comments = Comment.rejected_comments
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    @video = Video.find_by_id(@comment.video_id)
    @comments = Comment.find_all_by_video_id(@video.id)
  end

  def accept
    @comment = Comment.find_by_id(params[:id])
    @comment.update_attributes(:status => :accepted)
    flash[:notice] = 'This comment has been accepted.'
    redirect_to :back
  end

  def reject
    @comment = Comment.find_by_id(params[:id])
    @comment.update_attributes(:status => :rejected)
    flash[:notice] = 'This comment has been rejected.'
    redirect_to :back
  end

end
