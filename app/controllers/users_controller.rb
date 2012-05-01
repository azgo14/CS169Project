class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
    if params[:id] == current_user.id.to_s
      @comments = Comment.find_all_by_user_id(params[:id])
      @videos = Video.find_all_by_user_id(params[:id])
    else
      flash[:error] = 'You are not authorized to view this page'
      redirect_to videos_path
    end
  end

end
