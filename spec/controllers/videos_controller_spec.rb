require 'spec_helper'

describe VideosController do
 # render_views
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe '#index' do
    it 'should show the index page' do
      get :index
      response.should render_template('index')
    end
  end

  describe '#show' do

    describe 'showing a valid video' do
      it 'should show the details page for the given video' do
        fake_video = FactoryGirl.create(:video, :youtube_id => '0NwxHphsCxI')
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

    describe 'comments' do
      before(:each) do
        fake_video = FactoryGirl.create(:video, :id => '1234')
        pending_comment = FactoryGirl.create(:comment, :content => 'this is pending',
                                             :status => 'pending')
        approved_comment = FactoryGirl.create(:comment, :content => 'this is approved',
                                              :status => 'approved')
        rejected_comment = FactoryGirl.create(:comment, :content => 'this is rejected',
                                              :status => 'rejected')
      end

      it 'should ask the database for the corresponding comments' do
        Video.should_receive(:find_by_id).with('1234').and_return(fake_video)
        fake_video.should_receive(:comments)
        get :show, {:id => '1234'}
      end

      it 'should only find the approved comments' do
        get :show, {:id => '1234'}
        response.should have_selector('.comment', :content => 'this is approved')
        response.should_not have_selector('.comment', :content => 'this is pending')
        response.should_not have_selector('.comment', :content => 'this is rejected')
      end
    end

    describe 'ratings' do
      it 'should allow me to submit an anonymous rating' do
        fake_video = FactoryGirl.create(:video, :youtube_id => '0NwxHphsCxI', :rating => 5)
        Video.should_receive(:find_by_id).with('1234').and_return(fake_video)
        post :like, {:id => '1234'}
        fake_video.rating.should eq(6)
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
        Video.stub(:upload).and_return('testid')
        post :create, :name => 'batman', :email => 'dark@knight.com', :age => 25, :ethnicity => {:chinese => 1}, :language => 'chinese', :location => 'batcave', :video => fixture_file_upload('/files/test.mp4', 'video/mp4'), :why => 'because', :how => 'somehow', :hope => 'hopeful', :release => 'true'
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
        video.youtube_id.should == 'testid'
      end
    end

    describe 'submitting a video with insufficient information' do
      before do
        Video.stub(:upload).and_return('testid')
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
  describe '#search' do
    before(:each) do
      @vid1 = FactoryGirl.create(:video, :id => '1721', :name => "Mario Lui", :age => "21", :ethnicity => "Chinese", :location => "California")
      @vid2 = FactoryGirl.create(:video, :id => '1722', :name => "Wario Lui", :age => "25", :ethnicity => "Japanese", :location => "California")
      @vid3 = FactoryGirl.create(:video, :id => '1723', :name => "Bob Joe", :age => "21", :ethnicity => "Japanese", :location => "California")
    end

    it "should show the video search page" do
      get :search
      response.should render_template('search')
    end

    it "should return correct result for search by name" do
      Video.should_receive(:search).with("Lui", "name").and_return([@vid1,@vid2])
      get :search, :search_text => "Lui", :search_condition => "Name"
      assigns(:videos).should == [@vid1,@vid2]
    end

    it "should return correct result for search by age" do
      Video.should_receive(:search).with("21", "age").and_return([@vid1,@vid3])
      get :search, :search_text => "21", :search_condition => "Age"
      assigns(:videos).should == [@vid1,@vid3]
    end

    it "should return correct result for search by location" do
      Video.should_receive(:search).with("California", "location").and_return([@vid1,@vid2,@vid3])
      get :search, :search_text => "California", :search_condition => "Location"
      assigns(:videos).should == [@vid1,@vid2,@vid3]
    end

    it "should return correct result for search by ethnicity" do
      Video.should_receive(:search).with("Japanese", "ethnicity").and_return([@vid2,@vid3])
      get :search, :search_text => "Japanese", :search_condition => "Ethnicity"
      assigns(:videos).should == [@vid2,@vid3]
    end
  end
end
