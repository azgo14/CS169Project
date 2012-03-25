require 'spec_helper'

describe Video do

  describe '#make_public' do
    it 'should make the video publicly viewable on youtube' do
    end
  end

  describe '#make_private' do
    it 'should make the video not publicly viewable on youtube' do
    end
  end

  describe '#sort' do
    it 'should sort pending videos by submission date when the argument is :pending' do
      Video.should_receive(:find).with(:all, :order => :submission_date, :conditions => {:status => :pending})
      Video.sort(:pending)
    end

    it 'should sort accepted videos by submission date when the argument is :accepted' do
      Video.should_receive(:find).with(:all, :order => :submission_date, :conditions => {:status => :accepted})
      Video.sort(:accepted)
    end

    it 'should sort rejected videos by submission date when the argument is :rejected' do
      Video.should_receive(:find).with(:all, :order => :submission_date, :conditions => {:status => :rejected})
      Video.sort(:rejected)
    end
  end

  describe '#pending_videos, #accepted_videos, #rejected_videos' do

    before :each do
      @videos = [mock('Video'), mock('Video')]
    end

    describe '#pending_videos' do
      it 'should return a collection of pending videos, sorted by submission date' do
        Video.should_receive(:sort).with(:pending).and_return(@videos)
        Video.pending_videos
      end
    end

    describe '#accepted_videos' do
      it 'should return a collection of accepted videos, sorted by submission date' do
        Video.should_receive(:sort).with(:accepted).and_return(@videos)
        Video.accepted_videos
      end
    end

    describe '#rejected_videos' do
      it 'should return a collection of rejected videos, sorted by submission date' do
        Video.should_receive(:sort).with(:rejected).and_return(@videos)
        Video.rejected_videos
      end
    end
  end
end
