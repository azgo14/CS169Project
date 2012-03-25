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

    describe 'video uploading' do
      it 'should store information for a new video' do
        post :index, :name => 'batman', :email => 'dark@night.com', :age => 25, :ethnicity => {:chinese => 1}, :language => 'chinese', :location => 'batcave', :video => 'file', :why => 'because', :how => 'somehow', :hope => 'hopeful', :release => 'true'
        response.should redirect_to(videos_path)
        videos = Video.find_all
        videos.size.should == 1
        videos[0][:name].should == 'batman'
      end
    end

  end

end
