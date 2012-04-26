require 'spec_helper'

describe MessagesController do
  before(:each) do
    @user = FactoryGirl.create(:user, :email => 'asdf@asdf.asdf')
    @admin_user = FactoryGirl.create(:user, :email => 'aeou@aeou.aeou')
    @admin_user.admin = true;
    sign_in @user
  end

  describe '#index' do
    it 'should show the index page' do
      get :index
      response.should render_template('messages/index')
      Comment.should_receive(:find_all_by_to_user).with(@user.id)
    end
    it 'should show the admin messages for admins' do
      sign_in @admin_user
      get :index
      response.should render_template('messages/index')
      Comment.should_receive(:find_all_by_to_user).with('admin')
    end
  end

  describe '#sent' do
    it 'should show the sent page' do
      get :sent
      response.should render_template('messages/sent')
      Comment.should_receive(:find_all_by_from_user).with(@user.id)
    end
    it 'should show the admin sent messages' do
      sign_in @admin_user
      get :sent
      response.should render_template('messages/sent')
      Comment.should_receive(:find_all_by_from_user).with('admin')
    end
  end


  describe '#show' do
    it 'should show a specific message and update read status' do
      fake_message = FactoryGirl.create(:message,
                                        :id => '1234',
                                        :to_user => @user.id,
                                        :from_user => 'admin',
                                        :subject => 'asdf',
                                        :status => 'unread',
                                        :content => 'aeou')
      Video.should_receive(:find_by_id).with('1234').and_return(fake_message)
      get :show, {:id => '1234'}
      response.should render_template('messages/show')
      fake_message.status.should = 'read'
    end
    it 'should not update read status for authored messages' do
      fake_message = FactoryGirl.create(:message,
                                        :id => '1234',
                                        :to_user => 'admin',
                                        :from_user => @user.id,
                                        :subject => 'asdf',
                                        :status => 'unread',
                                        :content => 'aeou')
      Video.should_receive(:find_by_id).with('1234').and_return(fake_message)
      get :show, {:id => '1234'}
      response.should render_template('messages/show')
      fake_message.status.should_not = 'read'
    end
    it 'should not be able to show messages not directed to or written by the user' do
      fake_message = FactoryGirl.create(:message,
                                        :id => '1234',
                                        :to_user => @user.id + 2,
                                        :from_user => 'admin',
                                        :subject => 'asdf',
                                        :status => 'unread',
                                        :content => 'aeou')
      fake_message2 = FactoryGirl.create(:message,
                                         :id => '1235',
                                         :to_user => 'admin',
                                         :from_user => @user.id + 3,
                                         :subject => 'asdf',
                                         :status => 'unread',
                                         :content => 'aeou')
      Video.should_receive(:find_by_id).with('1234').and_return(fake_message)
      get :show, {:id => '1234'}
      response.should redirect_to(message_path)
      flash[:error].should == 'You are not allowed to view this message'
      fake_message.status.should_not = 'read'

      Video.should_receive(:find_by_id).with('1235').and_return(fake_message2)
      get :show, {:id => '1235'}
      response.should redirect_to(message_path)
      flash[:error].should == 'You are not allowed to view this message'
      fake_message2.status.should_not = 'read'
    end
  end

  describe '#new' do
    it 'should show the new message page' do
      get :new
      response.should render_template('messages/new')
    end
  end

  describe '#create' do
    describe 'send a message to admin should create a new message' do
      before(:each) do
        post :create, :subject => '123', :content => '456'
      end

      it 'should try to create a message and redirect to it' do
        fake_message = FactoryGirl.create(:message,
                                          :id => '12345')
        Message.should_receive(:new).with(:to_user => 'admin',
                                          :from_user => @user.id,
                                          :subject => '123',
                                          :content => '456',
                                          :status => 'unread').and_return(fake_message)
        response.should redirect_to(messages_path(fake_message))
      end

      it 'should create a new message' do
        msgs = Message.find(:all)
        msgs.size.should == 1
        msg = msgs[0]
        msg.to_user.should == 'admin'
        msg.from_user.should == @user.id
        msg.subject.should == '123'
        msg.content.should == '456'
        msg.status.should == 'unread'
      end
    end

    describe 'submitting a message with insufficient information' do
      it 'should not add anything to the database' do
        post :create, :subject => '1234'
        post :create, :content => '4567'
        Comment.find(:all).size.should == 0
        flash[:error].should == 'Please fill in all missing fields'
      end
    end
  end
end



