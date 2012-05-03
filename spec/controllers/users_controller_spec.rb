require 'spec_helper'

describe UsersController do

  render_views

  before(:each) do
    @user = FactoryGirl.create(:user, :id => '1')
    sign_in @user
  end

  describe '#show' do

    it 'should display the profile for the correct user' do
      get :show, {:id => @user.id}
      response.should render_template('users/show')
    end

    it 'should display all videos, comments, and messages by the user' do
      fake_video = FactoryGirl.create(:video, :user_id=> @user.id,
                                      :title => 'test video')
      fake_comment = FactoryGirl.create(:comment, :user_id => @user.id,
                                        :content => 'Some comment here')
      fake_message = FactoryGirl.create(:message, :to_user => -1,
                                        :from_user => @user.id,
                                        :subject => 'subject line here',
                                        :message => 'Some message here')
      get :show, {:id => @user.id}
      response.body.should include('test video')
      response.body.should include('Some comment here')
      response.body.should include('subject line here')
    end

  end

end
