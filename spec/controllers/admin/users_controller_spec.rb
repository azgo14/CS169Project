require 'spec_helper'

describe Admin::UsersController do
  ##### POSTPONED UNTIL NEXT ITERATION DUE TO BETTER FEATURE ALIGNMENT #####
  # before(:each) do
  #   @admin = FactoryGirl.create(:admin)
  #   sign_in @admin
  #   @user = FactoryGirl.create(:user, :id => 1)
  # end

  # describe '#block' do
  #   it 'should prevent a user from submitting comments' do
  #     Users.should_receive(:find_by_id).with('1').and_return(@user)
  #     @user.should_receive(:update_attributes).with(:blocked => true)
  #   end
  # end

  # describe '#unblock' do
  #   it 'should allow a user to submit comments' do
  #     Users.should_receive(:find_by_id).with('1').and_return(@user)
  #     @user.should_receive(:update_attributes).with(:blocked => false)
  #   end
  # end
end
