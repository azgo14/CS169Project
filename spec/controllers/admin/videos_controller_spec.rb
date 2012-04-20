require 'spec_helper'

describe Admin::VideosController do
  before (:each) do
    @user = FactoryGirl.create(:admin)
    sign_in @user
  end

  describe '#index' do
    it 'should show me a correctly partitioned list of videos' do
      videos = [FactoryGirl.create(:video), FactoryGirl.create(:video)]
      Video.stub(:pending_videos).and_return(videos)
      Video.stub(:accepted_videos).and_return(videos)
      Video.stub(:rejected_videos).and_return(videos)
      get :index
      assigns(:pending_videos).should == videos
      assigns(:accepted_videos).should == videos
      assigns(:rejected_videos).should == videos
    end
  end

  describe '#show' do
    it 'should show the admin detail page for the given video' do
      comments = [mock('Comment'), mock('Comment')]
      video = FactoryGirl.create(:video)
      Video.should_receive(:find_by_id).with('1').and_return(video)
      Comment.should_receive(:find_all_by_video_id_and_status).with('1', 'accepted').and_return(comments)
      get :show, :id => 1
      assigns(:video).should == video
      assigns(:comments).should == comments
      response.should render_template('show')
    end
  end

  describe '#update' do
    it 'should update the attributes of the given video' do
      video = FactoryGirl.create(:video)
      Video.should_receive(:find_by_id).with('1').and_return(video)
      video.should_receive(:update_attributes!).with('why' => 'because', 'title' => 'new title')
      post :update, {:id => 1, :video => {'why' => 'because', 'title' => 'new title'}}
      flash[:notice].should == 'This video has been successfully updated.'
      response.should redirect_to admin_video_path(video)
    end
  end


  describe 'Changing Video Status' do
    before :each do
      @video = FactoryGirl.create(:video)
      Video.should_receive(:find_by_id).with('1').and_return(@video)
    end

    describe 'accepting a video' do
      after :each do
        @video.should_receive(:update_attributes).with(:status => :accepted)
        @video.stub(:status).and_return(:accepted)
        post :accept, :id => 1
        @video.status.should == :accepted
        flash[:notice].should == 'This video has been accepted.'
        response.should redirect_to admin_video_path(@video)
      end

      it 'should allow me to accept a pending video' do
        @video.stub(:status).and_return(:pending)
      end

      it 'should allow me to accept a rejected video' do
        @video.stub(:status).and_return(:rejected)
      end

      it 'should not affect the video if I accept an accepted video' do
        @video.stub(:status).and_return(:accepted)
      end
    end

    describe 'rejecting a video' do
      after :each do
        @video.should_receive(:update_attributes).with(:status => :rejected)
        @video.stub(:status).and_return(:rejected)
        post :reject, :id => 1
        @video.status.should == :rejected
        response.should redirect_to admin_video_path(@video)
        flash[:notice].should == 'This video has been rejected.'
      end

      it 'should allow me to reject a pending video' do
        @video.stub(:status).and_return(:pending)
      end

      it 'should allow me to reject an accepted video' do
        @video.stub(:status).and_return(:accepted)
      end

      it 'should not affect the video if I reject a rejected video' do
        @video.stub(:status).and_return(:rejected)
      end
    end
  end
end
