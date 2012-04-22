require 'spec_helper'

describe Comment do
   describe '#sort' do
    it 'should sort pending comments by submission date when the argument is :pending' do
      Comment.should_receive(:find).with(:all, :order => 'created_at DESC', :conditions => {:status => :pending})
      Comment.sort(:pending)
    end

    it 'should sort accepted comments by submission date when the argument is :accepted' do
      Comment.should_receive(:find).with(:all, :order => 'created_at DESC', :conditions => {:status => :accepted})
      Comment.sort(:accepted)
    end

    it 'should sort rejected comments by submission date when the argument is :rejected' do
      Comment.should_receive(:find).with(:all, :order =>'created_at DESC', :conditions => {:status => :rejected})
      Comment.sort(:rejected)
    end
  end

  describe '#pending_comments, #accepted_comments, #rejected_comments' do

    before :each do
      @comments = [mock('Comment'), mock('Comment')]
    end

    describe '#pending_comments' do
      it 'should return a collection of pending comments, sorted by submission date' do
        Comment.should_receive(:sort).with(:pending).and_return(@comments)
        Comment.pending_comments
      end
    end

    describe '#accepted_comments' do
      it 'should return a collection of accepted comments, sorted by submission date' do
        Comment.should_receive(:sort).with(:accepted).and_return(@comments)
        Comment.accepted_comments
      end
    end

    describe '#rejected_comments' do
      it 'should return a collection of rejected comments, sorted by submission date' do
        Comment.should_receive(:sort).with(:rejected).and_return(@comments)
        Comment.rejected_comments
      end
    end
  end

  describe '#name' do

    before :each do
      @user = FactoryGirl.create(:user, :email => 'user@api.com')
    end

    it "should return 'Anonymous' if submitted anonymously" do
      comment = FactoryGirl.create(:comment, :anonymous => true)
      @user.should_not_receive(:email)
      comment.name
    end

    it 'should return the email address of the user who submitted the comment' do
      comment = FactoryGirl.create(:comment, :anonymous => false, :user => @user)
      @user.should_receive(:email).and_return('user@api.com')
      comment.name
    end
  end
end
