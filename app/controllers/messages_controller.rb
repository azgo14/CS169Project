class MessagesController < ApplicationController
  def index
    user = current_user
    if user == nil
      flash[:error] = 'You are not logged in'
      @messages = []
    else
      @messages = Message.messages_to(user.id)
    end
  end
  def sent_messages
    user = current_user
    if user == nil
      flash[:error] = 'You are not logged in'
      @messages = []
    else
      @messages = Message.messages_from(user.id)
    end
  end
  def show
    id = params[:id]
    @message = Message.find_by_id(id)
    if not(@message.viewable_by(current_user.id))
      flash[:error] = 'You are not allowed to view this message'
      redirect_to messages_path
    end
  end
end
