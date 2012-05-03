class Email
  
  attr_accessor :to, :subject, :body

  def initialize(to, subject, body)
    @to = to
    @subject = subject
    @body = body
  end

end
