require 'spec_helper'

describe Admin::VideosController do
  describe '#index' do
    it 'should show me a correctly partitioned list of videos' do
      videos = [mock('Video'), mock('Video')]
      Movie.stub(:pending_videos).and_return(videos)
      Movie.stub(:accepted_videos).and_return(videos)
      Movie.stub(:rejected_videos).and_return(videos)
      get :index
      assigns(:pending_videos).should == videos
      assigns(:accepted_videos).should == videos
      assigns(:rejected_videos).should == videos
    end
  end

  describe '#show' do
    it 'should show the admin details page for the given video' do
      get :show, :id => '0NwxHphsCxI'
      response.should render_template('show')
      response.should have_selector('iframe', :src => 'http://www.youtube.com/embed/0NwxHphsCxI')
      response.should have_button('Accept')
      response.should have_button('Reject')
      response.should have_button('Pend')
    end
  end

  describe 'Updating Video Status' do
    before :each do
      @video = mock('Video')
      Video.should_receive(:find).with(1).and_return(@video)
    end

    describe 'accepting a video' do
      after :each do
        @video.should_receive(:update_attributes).with(:status => :accepted)
        @video.stub(:status).and_return(:accepted)
        post :accept, :id => 1
        @video.status.should == :accepted
        response.should redirect_to :action => 'index'
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
        response.should_redirect_to :action => 'index'
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
    
    describe 'pending a video' do
      after :each do
        @video.should_receive(:update_attributes).with(:status => :pending)
        @video.stub(:status).and_return(:pending)
        post :pend, :id => 1
        @video.status.should == :pending
        response.should_redirect_to :action => 'index'
      end

      it 'should allow me to pend an accepted video' do
        @video.stub(:status).and_return(:accepted)
      end
    
      it 'should allow me to pend a rejected video' do
        @video.stub(:status).and_return(:rejected)
      end
    
      it 'should not affect the video if I pend a pending video' do
        @video.stub(:status).and_return(:pending)
      end
    end
  end
end