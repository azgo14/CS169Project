require 'spec_helper'

describe Video do

  describe '#upload_to_youtube' do
    it 'should privately upload the video to youtube' do
    end
  end

  describe '#make_public' do
    it 'should make the video publicly viewable on youtube' do
    end
  end

  describe '#make_private' do
    it 'should make the video not publicly viewable on youtube' do
    end
  end

  describe '#sort' do
  before :each do
    @sorted_videos = [mock('Video'), mock('Video'), mock('Video')]
  end
    it 'should sort pending movies by submission date when the argument is :pending' do
      Video.should_receive(:find).with(:all, :order => :submission_date, :conditions => {:status => :pending}).and_return(@sorted_videos)
      Video.sort(:pending)
      assigns(:pending_videos).should == @sorted_videos
    end
    
    it 'should sort accepted movies by submission date when the argument is :accepted' do
      Video.should_receive(:find).with(:all, :order => :submission_date, :conditions => {:status => :accepted}).and_return(@sorted_videos) 
      Video.sort(:accepted)
      assigns(:accepted_videos).should == @sorted_videos
    end
    
    it 'should sort rejected movies by submission date when the argument is :rejected' do
      Video.should_receive(:find).with(:all, :order => :submission_date, :conditions => {:status => :rejected}).and_return(@sorted_videos)
      Video.sort(:rejected)
      assigns(:rejected_videos).should == @sorted_videos
    end
  end
end
