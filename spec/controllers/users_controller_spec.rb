require 'spec_helper'

describe UsersController do

  before(:each) do
    @user = FactoryGirl.create(:user, :id => '1')
    sign_in @user
  end

  describe '#show' do

    it 'should display the profile for the correct user' do
      get :show, {:id => @user.id}
      response.should render_template('users/show')
    end

    it 'should display all comments and messages by the user' do
      fake_comment = FactoryGirl.create(:comment, :user_id => @user.id,
                                        :content => 'Some comment here')
      fake_message = FactoryGirl.create(:message, :to_user => 'admin',
                                        :from_user => @user.id,
                                        :content => 'Some message here')
      get :show, {:id => @user.id}
      response.should have_selector('.comments', :text => 'Some comment here')
      response.should have_selector('.messages', :text => 'Some message here')
    end

  end

end
