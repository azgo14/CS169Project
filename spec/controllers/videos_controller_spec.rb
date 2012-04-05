require 'spec_helper'

describe VideosController do
 # render_views

  describe '#index' do
    it 'should show the index page' do
      get :index
      response.should render_template('index')
    end
  end

  describe '#show' do

    describe 'showing a valid video' do
      it 'should show the details page for the given video' do
        fake_video = Factory(:video, :youtube_id => '0NwxHphsCxI')
        Video.should_receive(:find_by_id).with("1234").and_return(fake_video)
        get :show, {:id => '1234'}
        response.should render_template('videos/show')
        #put response.should have_whatever in the view spec
      end
    end

    describe 'showing an invalid video' do
      it 'should flash a notice and redirect to the index page' do
        get :show, :id => 'a'
        flash[:error].should == 'Invalid video id'
        response.should redirect_to(videos_path)
      end
    end

  end

  describe '#new' do
    it 'should show the new submission page' do
      get :new
      response.should render_template('videos/new')
    end
  end

  describe '#create' do

    describe 'submitting a video with complete information' do
      before(:each) do
        post :create, :name => 'batman', :email => 'dark@knight.com', :age => 25, :ethnicity => {:chinese => 1}, :language => 'chinese', :location => 'batcave', :video => 'file', :why => 'because', :how => 'somehow', :hope => 'hopeful', :release => 'true'
      end

      it 'should redirect to the index page upon completion' do
        response.should redirect_to(videos_path)
      end

      it 'should add a new pending video' do
        videos = Video.find(:all)
        videos.size.should == 1
        videos[0].status.should == 'pending'
      end

      it 'should store information about the video' do
        video = Video.find(:all)[0]
        video.name.should == 'batman'
        video.email.should == 'dark@knight.com'
        video.age.should == 25
        video.language.should == 'chinese'
        video.location.should == 'batcave'
        video.why.should == 'because'
        video.how.should == 'somehow'
        video.hope.should == 'hopeful'
        video.youtube_id.should_not == ''
      end
    end

    describe 'submitting a video with insufficient information' do
      before do
        post :create, :name => 'batman'
      end

      it 'should flash a notice and redirect to the submission page' do
        response.should redirect_to(new_video_path)
        flash[:error].should == 'Please fill in all missing fields'
      end

      it 'should not add a new video' do
        Video.find(:all).size.should == 0
      end
    end

  end

end
