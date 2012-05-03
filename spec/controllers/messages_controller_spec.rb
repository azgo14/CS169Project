require 'spec_helper'

describe MessagesController do
  before(:each) do
    @user = FactoryGirl.create(:user, :email => 'asdf@asdf.asdf')
    @admin_user = FactoryGirl.create(:user, :email => 'aeou@aeou.aeou')
    @admin_user.admin = true;
    @admin_user.save!
    sign_in @user
  end

  describe '#index' do
    it 'should show the index page' do
      Message.should_receive(:find_all_by_to_user).with(@user.id)
      get :index
      response.should render_template('messages/index')
    end
    it 'should show the admin messages for admins' do
      sign_in @admin_user
      Message.should_receive(:find_all_by_to_user).with(-1)
      get :index
      response.should render_template('messages/index')
    end
  end

  describe '#sent' do
    it 'should show the sent page' do
      Message.should_receive(:find_all_by_from_user).with(@user.id)
      get :sent
      response.should render_template('messages/sent')
    end
    it 'should show the admin sent messages' do
      sign_in @admin_user
      Message.should_receive(:find_all_by_from_user).with(-1)
      get :sent
      response.should render_template('messages/sent')
    end
  end


  describe '#show' do
    it 'should show a specific message and update read status' do
      fake_message = FactoryGirl.create(:message,
                                        :id => '1234',
                                        :to_user => @user.id,
                                        :from_user => -1,
                                        :subject => 'asdf',
                                        :status => 'unread',
                                        :message => 'aeou')
      Message.should_receive(:find_by_id).with('1234').and_return(fake_message)
      get :show, {:id => '1234'}
      response.should render_template('messages/show')
      fake_message.status.should == 'read'
    end
    it 'should not update read status for authored messages' do
      fake_message = FactoryGirl.create(:message,
                                        :id => '1234',
                                        :to_user => -1,
                                        :from_user => @user.id,
                                        :subject => 'asdf',
                                        :status => 'unread',
                                        :message => 'aeou')
      Message.should_receive(:find_by_id).with('1234').and_return(fake_message)
      get :show, {:id => '1234'}
      response.should render_template('messages/show')
      fake_message.status.should_not == 'read'
    end
    it 'should not be able to show messages not directed to or written by the user' do
      fake_message = FactoryGirl.create(:message,
                                        :id => '1234',
                                        :to_user => @user.id + 2,
                                        :from_user => -1,
                                        :subject => 'asdf',
                                        :status => 'unread',
                                        :message => 'aeou')
      fake_message2 = FactoryGirl.create(:message,
                                         :id => '1235',
                                         :to_user => -1,
                                         :from_user => @user.id + 3,
                                         :subject => 'asdf',
                                         :status => 'unread',
                                         :message => 'aeou')
      Message.should_receive(:find_by_id).with('1234').and_return(fake_message)
      get :show, {:id => '1234'}
      response.should redirect_to(messages_path)
      flash[:error].should == 'You are not allowed to view this message'
      fake_message.status.should_not == 'read'

      Message.should_receive(:find_by_id).with('1235').and_return(fake_message2)
      get :show, {:id => '1235'}
      response.should redirect_to(messages_path)
      flash[:error].should == 'You are not allowed to view this message'
      fake_message2.status.should_not == 'read'
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

      it 'should try to create a message and redirect to it' do
        fake_message = FactoryGirl.create(:message,
                                          :id => '12345')
        Message.should_receive(:new).with(:subject => '123',
                                          :message => '456', 
                                          :from_user => @user.id,
                                          :to_user => -1,
                                          :status => 'unread').and_return(fake_message)
        post :create, :subject => '123', :message => '456'
        response.should redirect_to(messages_path(fake_message))
      end

      it 'should create a new message' do
        post :create, :subject => '123', :message => '456'
        msgs = Message.find(:all)
        msgs.size.should == 1
        msg = msgs[0]
        msg.to_user.should == -1
        msg.from_user.should == @user.id
        msg.subject.should == '123'
        msg.message.should == '456'
        msg.status.should == 'unread'
      end
    end

    describe 'submitting a message with insufficient information' do
      it 'should not add anything to the database' do
        post :create, :subject => '1234'
        post :create, :message => '4567'
        Message.find(:all).size.should == 0
        flash[:error].should == 'Please fill in all missing fields'
      end
    end
  end
end



