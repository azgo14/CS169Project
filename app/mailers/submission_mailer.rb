class SubmissionMailer < ActionMailer::Base
  def submission_accepted(video)
    @video = video
    mail(
        :from => 'info@banyantreeproject.org',
        :to => video.email,
        :subject => 'Your Digital Story Submission'
    )
  end
end

