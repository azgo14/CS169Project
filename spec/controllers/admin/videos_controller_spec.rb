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
    end

    describe 'accepting a video' do

      before :each do
        Video.should_receive(:find_by_id).with('1').and_return(@video)
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

      it 'should redirect to admin_email_path' do
        get :reject, :id => 1
        response.should redirect_to(admin_email_path(:id => 1, :reject => 'true'))
      end

      describe '#email' do
        before :each do
          Video.should_receive(:find_by_id).with('1').and_return(@video)
        end
        
        it 'should present an email form' do
          get :email, :id => 1
          response.should render_template(:email)
        end
        
        it 'should make the subject "Update on your Taking Root story submission" if the video is being rejected' do
          get :email, :id => 1, :reject => 'true'
          assigns(:video).should == @video
          assigns(:reject).should == true
          assigns(:subject).should == "Update on your Taking Root story submission"
        end
        
        it 'should make the subject "Questions about your Taking Root story submission" if the video is not being rejected' do
          get :email, :id => 1, :reject => 'false'
          assigns(:video).should == @video
          assigns(:reject).should == false
          assigns(:subject).should == "Questions about your Taking Root story submission"
        end
      end
    end
  end
  
  describe '#send_email' do
    before :each do
      @video = FactoryGirl.create(:video)
      Video.should_receive(:find_by_id).with('1').and_return(@video)
      @email = mock('Email')
      Email.should_receive(:new).with('email@address.com', 'My subject', 'My message').and_return(@email)
      @message = SubmissionMailer.should_receive(:custom_message).with(@email).and_return(mock('Message', :deliver => true))
      @message.stub(:deliver)
    end 

    it 'should change the video status to rejected when rejecting a video' do
      @video.should_receive(:update_attributes).with(:status => :rejected)
      post :send_email, {:id => '1', :reject => 'true', :email => {:to => 'email@address.com', :subject => 'My subject', :body => 'My message'}}
      response.should redirect_to admin_video_path(@video)
      flash[:notice].should == 'This video has been rejected.'
    end

    it 'should not change the video status if the video is pending' do
      @video.should_not_receive(:update_attributes)
      post :send_email, {:id => '1', :reject => 'false', :email => {:to => 'email@address.com', :subject => 'My subject', :body => 'My message'}}
      @video.status.should == 'pending'
      response.should redirect_to admin_video_path(@video)
      flash[:notice].should == 'Your email has been sent.'
    end
  end
end
