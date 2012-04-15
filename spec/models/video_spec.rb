require 'spec_helper'

describe Video do

  describe '#sort' do
    it 'should sort pending videos by submission date when the argument is :pending' do
      Video.should_receive(:find).with(:all, :order => 'created_at DESC', :conditions => {:status => :pending})
      Video.sort(:pending)
    end

    it 'should sort accepted videos by submission date when the argument is :accepted' do
      Video.should_receive(:find).with(:all, :order => 'created_at DESC', :conditions => {:status => :accepted})
      Video.sort(:accepted)
    end

    it 'should sort rejected videos by submission date when the argument is :rejected' do
      Video.should_receive(:find).with(:all, :order =>'created_at DESC', :conditions => {:status => :rejected})
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

  describe "#search" do
    it 'should call find_by_ethnicity on @search_term if @condition argument is :ethniticy and return a collection of videos with matching :ethnicity' do
      pending
    end

    it 'should call find_by_title on @search_term if @condition argument is :title and return a collection of videos with matching :title' do
      pending
    end

    it 'should call find_by_age on @search_term if @condition argument is :age and return a collection of videos with matching :age' do
      pending
    end

    it 'should call find_by_location on @search_term if @condition argument is :location and return a collection of videos with matching :location' do
      pending
    end

    it 'should return null if there are no videos with matching @search_term on @condition' do
      pending
    end

  end
end
