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
        fake_video = FactoryGirl.create(:video, :youtube_id => '0NwxHphsCxI', :status => 'accepted')
        Video.should_receive(:find_by_id).with("1234").and_return(fake_video)
        get :show, {:id => '1234'}
        response.should render_template('show')
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
        @fake_video = FactoryGirl.create(:video, :id => '1234', :status => 'accepted')
        pending_comment = FactoryGirl.create(:comment, :content => 'this is pending',
                                             :anonymous => true,
                                             :video_id => '1234',
                                             :status => 'pending')
        approved_comment = FactoryGirl.create(:comment, :content => 'this is approved',
                                              :anonymous => true,
                                              :video_id => '1234',
                                              :status => 'accepted')
        rejected_comment = FactoryGirl.create(:comment, :content => 'this is rejected',
                                              :anonymous => true,
                                              :video_id => '1234',
                                              :status => 'rejected')
      end

      it 'should ask the database for the corresponding comments' do
        Video.should_receive(:find_by_id).with('1234').and_return(@fake_video)
        #@fake_video.should_receive(:comments)
        Comment.should_receive(:find_all_by_video_id_and_status).with('1234',
                                                                    'accepted')
        get :show, {:id => '1234'}
      end
    end

#describe 'ratings' do
#      it 'should allow me to submit an anonymous rating' do
#        @fake_video = FactoryGirl.create(:video, :youtube_id => '0NwxHphsCxI', :likes => 5)
#       Video.should_receive(:find_by_id).with('1234').and_return(@fake_video)
#       post :like, {:id => '1234'}
#       @fake_video.likes.should eq(6)
#     end
#   end

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
      Video.stub_chain(:search, :page, :per).and_return([@vid1,@vid2])
      Video.should_receive(:search).with("Lui", "Name")
      get :search, :search_text => "Lui", :search_condition => "Name"
      assigns(:videos).should == [@vid1,@vid2]
    end

    it "should return correct result for search by age" do
      Video.stub_chain(:search, :page, :per).and_return([@vid1,@vid3])
      Video.should_receive(:search).with("21", "Age")
      get :search, :search_text => "21", :search_condition => "Age"
      assigns(:videos).should == [@vid1,@vid3]
    end

    it "should return correct result for search by location" do
      Video.stub_chain(:search, :page, :per).and_return([@vid1,@vid2,@vid3])
      Video.should_receive(:search).with("California", "Location")
      get :search, :search_text => "California", :search_condition => "Location"
      assigns(:videos).should == [@vid1,@vid2,@vid3]
    end

    it "should return correct result for search by ethnicity" do
      Video.stub_chain(:search, :page, :per).and_return([@vid2,@vid3])
      Video.should_receive(:search).with("Japanese", "Ethnicity")
      get :search, :search_text => "Japanese", :search_condition => "Ethnicity"
      assigns(:videos).should == [@vid2,@vid3]
    end
  end
  describe '#create_comment' do
    before(:each) do
      @fake_video = FactoryGirl.create(:video, :id => '1234', :youtube_id => '0NwxHphsCxI')
      @fake_id = @fake_video.id
      #Video.should_receive(:find_by_id).with("1234").and_return(@fake_video)
      #User.should_receive(:find_by_id).with('1').and_return(@user)
      #@user.should_receive(:blocked).and_return(false)
    end

    after(:each) do
    end


    describe 'submitting an anonymous comment with content' do
      it 'should allow an anonymous submission and mark the submission as pending' do
        Comment.should_receive(:new).with(:content=>'my comment',
                                           :video_id=>'1234',
                                           :user_id=>1,
                                           :anonymous=>'true',
                                           :status => 'pending')
        post :create_comment, {:id => @fake_id, :content => 'my comment',
          :user_id => '1', :anonymous => 'true'}
      end
      it 'should redirect back to the video' do
        post :create_comment, {:id => @fake_id, :content => 'my comment',
          :user_id => '1'}
        response.should redirect_to(video_path(@fake_id))
      end
      it 'should store the comment' do
        post :create_comment, {:id => @fake_id, :content => 'my comment',
          :user_id => '1'}
        @fake_video.comments[0].content.should == 'my comment'
      end
    end

    describe 'submitting an anonymous comment without content' do
      it 'should not create a new comment' do
      post :create_comment, {:id => @fake_id, :content => '',
        :user_id => '1'}
        Comment.should_not_receive(:new)
      end
      it 'should flash a notice and redirect back to the video' do
        post :create_comment, {:id => @fake_id, :content => '',
          :user_id => '1'}
        response.should redirect_to(video_path(@fake_id))
        flash[:error].should == 'Please fill in a comment'
      end
    end

    describe 'commenting as a blocked user' do
      before(:each) do
        @user = FactoryGirl.create(:user, :id => '3', :blocked => true,
                                   :email => 'fake@email.com')
        sign_in @user
        @fake_video = FactoryGirl.create(:video, :youtube_id => '0NwxHphsCxI')
        @request.env['HTTP_REFERER'] = video_path(@fake_video)
        post :create_comment, {:id => '1234', :content => 'my comment', :user_id => '1'}
      end  

      describe 'submitting an anonymous comment with content' do
        it 'should not create a new comment' do
          Comment.should_not_receive(:new)
        end
        it 'should flash a notice and redirect back to the video' do
          response.should redirect_to(video_path @fake_video)
          #flash[:error].should == "You are blocked from commenting"
        end
      end
    end

  end
end
