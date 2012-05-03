class MessagesController < ApplicationController
  def index
    user = current_user
    if user == nil
      flash[:error] = 'You are not logged in'
      redirect_to videos_path
      return
    else
      @messages = Message.messages_to(user.id)
    end
  end
  def sent
    user = current_user
    if user == nil
      flash[:error] = 'You are not logged in'
      redirect_to videos_path
    else
      @messages = Message.messages_from(user.id)
    end
  end
  def show
    id = params[:id]
    @message = Message.find_by_id(id)
    if @message == nil
      flash[:error] = 'Error loading message'
      redirect_to messages_path
      return
    end
    if not(@message.viewable_by(current_user.id))
      flash[:error] = 'You are not allowed to view this message'
      redirect_to messages_path
      return
    end
    if @message.to_me(current_user.id) and @message.status == 'unread'
      @message.status = 'read'
      @message.save!
    end
  end
  def new 
    user = current_user
    if user == nil
      flash[:error] = 'You are not logged in'
      redirect_to videos_path
      return
    end
    @is_admin = user.admin
  end
  def create
    if current_user == nil
      flash[:error] = 'You are not logged in'
      redirect_to videos_path
    end
    subject, message = params[:subject], params[:message]
    to, to_id = params[:to], params[:to_id]

    if subject == nil or message == nil
      flash[:error] = 'Please fill in all missing fields'
      redirect_to new_message_path
      return
    end

    if to == nil and to_id == nil
      to_id = -1 #admin
    elsif to != nil and to_id == nil
      target_user = User.find_by_email(to)
      if target_user == nil
        flash[:error] = 'Unable to find user with email: '+to
        redirect_to new_message_path
        return
      end
      to_id = target_user.id
    end

    if !current_user.admin and to_id != -1
      flash[:error] = 'You are not allowed to send messages to this user'
      redirect_to new_message_path
      return
    end

    from_id = current_user.id
    if current_user.admin
      from_id = -1
    end

    message = Message.new(:subject => subject, :message => message,
                          :from_user => from_id, :to_user => to_id,
                          :status => 'unread')
    message.save!

    flash[:note] = 'Thank you, your message has been sent!'
    redirect_to messages_path(message)

  end
end
