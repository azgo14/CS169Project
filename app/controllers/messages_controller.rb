class MessagesController < ApplicationController
  def index
    user = current_user
    if user == nil
      flash[:error] = 'You are not logged in'
      @messages = []
    else
      @messages = Message.find_all_by_to_user(user.id)
    end
  end
end
