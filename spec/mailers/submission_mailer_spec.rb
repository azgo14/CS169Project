require 'spec_helper'

describe SubmissionMailer do
    
   before :each do
    @video = FactoryGirl.create(:video)
  end
    
  describe '#submission_accepted' do
    it 'should create a message notifying the recipient that their submission was accepted' do
      message = SubmissionMailer.submission_accepted(@video)
      message.from.should == 'info@banyantreeproject.org'
      message.to.should == @video.email
      message.subject.should == 'Your story for Taking Root has been accepted'
    end
  end

  describe '#custom_message' do
    it 'should create a message with a personalized body' do
      test = "This is a test"
      subject = "My subject"
      message = SubmissionMailer.custom_message(@video, subject, text)
      message.from.should == 'info@banyantreeproject.org'
      message.to.should == @video.email
      message.subject.should == "My subject"
    end
  end
end
