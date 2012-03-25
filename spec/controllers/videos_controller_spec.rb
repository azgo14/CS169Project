require 'spec_helper'

describe VideosController do

  describe '#index' do
    it 'should show the index page' do
      get :index
      response.should render_template('index')
    end
  end

  describe '#show' do
    it 'should show the details page for the given video' do
      get :show, :youtube_id => '0NwxHphsCxI'
      response.should render_template('show')
      response.should have_selector('iframe', :src => 'http://www.youtube.com/embed/0NwxHphsCxI')
    end
  end

  describe '#new' do
    it 'should show the new submission page' do
      get :new
      response.should render_template('submission')
    end
  end

  describe '#create' do

    describe 'video creation' do

      before do
        post :index, :name => 'batman', :email => 'dark@knight.com', :age => 25, :ethnicity => {:chinese => 1}, :language => 'chinese', :location => 'batcave', :video => 'file', :why => 'because', :how => 'somehow', :hope => 'hopeful', :release => 'true'
      end

      it 'should redirect to the index page upon completion' do
        response.should redirect_to(videos_path)
      end

      it 'should add a new pending video' do
        videos = Video.find_all
        videos.size.should == 1
        videos[0].status.should == 'pending'
      end

      it 'should store information about the video' do
        video = Video.find_all[0]
        video.name.should == 'batman'
        video.email.should == 'dark@knight.com'
        video.age.should == 25
        video.language.should == 'chinese'
        video.location.should == 'batcave'
        video.why.should == 'because'
        video.how.should == 'somehow'
        video.hope.should == 'hopeful'
      end

    end

  end

end
