class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
    if params[:id] == current_user.id.to_s or current_user.admin
      @comments = Comment.find_all_by_user_id(params[:id])
      @user = User.find_by_id(params[:id])
      if !@user.blocked
        @status = @user.email + " is allowed to post comments."
      else
        @status = @user.email + " is blocked from posting comments."
      end
      @videos = Video.find_all_by_user_id(params[:id])
    else
      flash[:error] = 'You are not authorized to view this page'
      redirect_to videos_path
    end
  end
  
  def block
    @user = User.find_by_id(params[:id])
    @user.blocked = true
    if @user.save
      redirect_to user_path(@user)
    else
      flash[:error] = "There was a problem when trying to block " + @user.email
      redirect_to user_path(@user)
    end
  end
  
  def unblock
    @user = User.find_by_id(params[:id])
    @user.blocked = false
    if @user.save
      redirect_to user_path(@user)
    else
      flash[:error] = "There was a problem when trying to unblock " + @user.email
      redirect_to user_path(@user)
    end
  end

end
