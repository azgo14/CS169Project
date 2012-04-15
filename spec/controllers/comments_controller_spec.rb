require 'spec_helper'

describe CommentsController do
  describe '#new' do
    describe 'submitting an anonymous comment with content' do
      before(:each) do
        fake_video = Factory(:video, :youtube_id => '0NwxHphsCxI')
        Video.should_receive(:find_by_id).with("1234").and_return(fake_video)
        post :create, {:id => '1234', :content => 'my comment'}
      end
      it 'should allow an anonymous submission and mark the submission as pending' do
        Comments.should_receive(:new).with(:status => 'pending')
      end
      it 'should redirect back to the video' do
        response.should redirect_to(show_video_path)
      end
      it 'should store the comment' do
        fake_video.comments[0].content.should == 'my comment'
      end
    end

    describe 'submitting an anonymous comment without content' do
      before(:each) do
        fake_video = Factory(:video, :youtube_id => '0NwxHphsCxI')
        Video.should_receive(:find_by_id).with("1234").and_return(fake_video)
        post :create, {:id => '1234', :content => 'my comment'}
      end
      it 'should not create a new comment' do
        Comments.should_not_receive(:new)
      end
      it 'should flash a notice and redirect back to the video' do
        response.should redirect_to(show_video_path)
        flash[:error].should == 'Please fill in the comment before submitting'
      end
    end
  end
end
