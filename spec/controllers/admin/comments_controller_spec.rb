require 'spec_helper'

describe Admin::CommentsController do

  before(:each) do
    @user = FactoryGirl.create(:admin)
    sign_in @user
  end

  describe '#index' do
    it 'should show me a list of comments' do
    end
  end

  describe '#show' do
    it 'should show the admin details page for the given comment' do
    end
  end

  describe 'Updating Comment Status' do
    describe 'accepting a comment' do
    end

    describe 'rejecting a comment' do
    end
  end

end
