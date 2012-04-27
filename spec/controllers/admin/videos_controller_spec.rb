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
      Comment.should_receive(:find_all_by_video_id).with('1').and_return(comments)
      get :show, :id => 1
      assigns(:video).should == video
      assigns(:comments).should == comments
    end
  end

  describe '#update' do
    it 'should update the attributes of the given video' do
      video = FactoryGirl.create(:video)
      @request.env['HTTP_REFERER'] = admin_video_path(video)
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
      @request.env['HTTP_REFERER'] = admin_video_path(@video)
      Video.should_receive(:find_by_id).with('1').and_return(@video)
    end

    describe 'accepting a video' do

      before :each do
        @message = SubmissionMailer.should_receive(:submission_accepted).with(@video).and_return(mock('Message', :deliver => true))
        @message.stub(:deliver)
      end
      
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
  
      it 'should allow me to send a custom email to the story teller' do
        get :reject, :id => 1
        response.should render_template(:email)
      end
    end
  end

  describe '#send' do
    before :each do
      @video = FactoryGirl.create(:video)
      @text = "This is a test."
      @message = SubmissionMailer.should_receive(:custom_message).with(@video, @text).and_return(mock('Message', :deliver => true))
      @message.stub(:deliver) 
    end

    it 'should send the story teller an email when rejecting a video' do
      post :send, :id => 1, :text => @text, :reject => true
    end

    it 'should change the video status to rejected when rejecting a video' do
      @video.should_receive(:update_attributes).with(:status => :rejected)
      @video.stub(:status).and_return(:rejected)
      post :reject, :id => 1, :text => @text, :reject => true
      @video.status.should == :rejected
      response.should redirect_to admin_video_path(@video)
      flash[:notice].should == 'This video has been rejected.'
    end

    it 'should send the story teller an email if the video is pending' do
      post :send, :id => 1, :text => @text, :reject => false
    end

    it 'should not change the video status if the video is pending' do
      @video.should_not_receive(:update_attributes)
      post :send, :id => 1, :text => @text, :reject => false
      @video.status.should == 'pending'
      response.should redirect_to admin_video_path(@video)
      flash[:notice].should == 'Your email has been sent.'
    end
   end

  describe '#cancel' do
    
    before :each do
      @video = FactoryGirl.create(:video)
      @request.env['HTTP_REFERER'] = admin_video_path(@video)
      SubmissionMailer.should_not_receive(:custom_message)
    end

    after :each do
      response.should redirect_to admin_video_path(@video)
    end

    it 'should not send the story teller an email' do
      post :cancel
    end

    it 'should not change the video status' do
      @video.should_not_receive(:update_attributes)
      @video.status.should == 'pending'
    end
  end
end
