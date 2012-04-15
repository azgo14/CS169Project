require 'spec_helper'

describe CommentsController do
  describe '#create' do
    it 'should allow an anonymous submission and mark the submission as pending' do
      fake_video = Factory(:video, :youtube_id => '0NwxHphsCxI')
      Video.should_receive(:find_by_id).with("1234").and_return(fake_video)
      post :create, {:id => '1234', :content => 'my comment'}
      response.should redirect_to(show_video_path)
      Comments.should_receive(:new).with(:status => 'pending')
    end
  end
end
