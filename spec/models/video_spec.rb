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
    before(:each) do
      @vid1 = FactoryGirl.create(:video, :id => '1721', :name => "Bob Joe", :age => "21", :ethnicity => "Japanese", :location => "California")
      @vid2 = FactoryGirl.create(:video, :id => '1722', :name => "Mario Lui", :age => "21", :ethnicity => "Chinese", :location => "California")
      @vid3 = FactoryGirl.create(:video, :id => '1723', :name => "Wario Lui", :age => "25", :ethnicity => "Japanese", :location => "California")
    end

    it 'should call search on @search_text if @search_condition argument is "ethniticy" and return a collection of videos with matching "ethnicity"' do
      @search_text = "Japanese"
      @search_condition = "ethnicity"
      return_val = Video.search(@search_text, @search_condition)
      return_val.should == [@vid1,@vid3]
    end

    it 'should call search on @search_text if @search_condition argument is "title" and return a collection of videos with matching "title"' do
      @search_text = "Lui"
      @search_condition = "name"
      return_val = Video.search(@search_text, @search_condition)
      return_val.should == [@vid2,@vid3]
    end

    it 'should call search on @search_text if @search_condition argument is "age" and return a collection of videos with matching "age"' do
      @search_text = "21"
      @search_condition = "age"
      return_val = Video.search(@search_text, @search_condition)
      return_val.should == [@vid1,@vid2]
    end

    it 'should call search on @search_text if @search_condition argument is "location" and return a collection of videos with matching "location"' do
      @search_text = "California"
      @search_condition = "location"
      return_val = Video.search(@search_text, @search_condition)
      return_val.should == [@vid1,@vid2,@vid3]
    end

    it 'should return empty array if there are no videos with matching @search_term on @search_condition' do
      @search_text = "Andrew"
      @search_condition = "name"
      return_val = Video.search(@search_text, @search_condition)
      return_val.should == []
    end

  end
end
