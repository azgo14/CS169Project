require 'spec_helper'

describe Admin::CommentsController do

  before(:each) do
    @user = FactoryGirl.create(:admin)
    sign_in @user
  end

  describe '#index' do
    it 'should show me a list of comments' do
      comments = [FactoryGirl.create(:comment), FactoryGirl.create(:comment)]
      Comment.stub(:pending_comments).and_return(comments)
      Comment.stub(:accepted_comments).and_return(comments)
      Comment.stub(:rejected_comments).and_return(comments)
      get :index
      assigns(:pending_comments).should == comments
      assigns(:accepted_comments).should == comments
      assigns(:rejected_comments).should == comments
    end
  end

  describe '#show' do
    it 'should show the comment on the admin details page for the corresponding video' do
      comment = FactoryGirl.create(:comment, :id => 1, :video_id => 1)
      video = FactoryGirl.create(:video, :id => 1)
      Comment.should_receive(:find_by_id).with('1').and_return(comment)
      comment.should_receive(:video_id).and_return('1')
      get :show, :id => 1
      assigns(:video).should == video
      assigns(:comments).should == [comment]
      response.should render_template('show')
    end
  end

  describe 'Updating Comment Status' do
     before :each do
      @comment = FactoryGirl.create(:comment)
      Comment.should_receive(:find_by_id).with('1').and_return(@comment)
      @request.env['HTTP_REFERER'] = 'http://test.host/admin/comments'
    end

    describe 'accepting a comment' do
       after :each do
        @comment.should_receive(:update_attributes).with(:status => :accepted)
        @comment.stub(:status).and_return(:accepted)
        post :accept, :id => 1
        @comment.status.should == :accepted
        response.should redirect_to :action => 'index'
      end

      it 'should allow me to accept a pending comment' do
        @comment.stub(:status).and_return(:pending)
      end

      it 'should allow me to accept a rejected video' do
        @comment.stub(:status).and_return(:rejected)
      end

      it 'should not affect the comment if I accept an accepted comment' do
        @comment.stub(:status).and_return(:accepted)
      end
    end

    describe 'rejecting a comment' do
       after :each do
        @comment.should_receive(:update_attributes).with(:status => :rejected)
        @comment.stub(:status).and_return(:rejected)
        post :reject, :id => 1
        @comment.status.should == :rejected
        response.should redirect_to :action => 'index'
      end

      it 'should allow me to reject a pending comment' do
        @comment.stub(:status).and_return(:pending)
      end

      it 'should allow me to reject a rejected video' do
        @comment.stub(:status).and_return(:accepted)
      end

      it 'should not affect the comment if I reject a rejected comment' do
        @comment.stub(:status).and_return(:rejected)
      end
    end

  end
end
