require 'spec_helper'

describe SubmissionMailer do
    
  describe '#submission_accepted' do
    it 'should create a message notifying the recipient that their submission was accepted' do
      video = FactoryGirl.create(:video)
      message = SubmissionMailer.submission_accepted(video)
      message.from.should == ['info@banyantreeproject.org']
      message.to.should == [video.email]
      message.subject.should == 'Your story for Taking Root has been accepted'
    end
  end

  describe '#custom_message' do
    it 'should create a message with a personalized body' do
      email = mock('Email', :to => 'email@address.com', :subject => 'My subject', :body => 'My message')
      message = SubmissionMailer.custom_message(email)
      message.from.should == ['info@banyantreeproject.org']
      message.to.should == [email.to]
      message.subject.should == email.subject
    end
  end
end
