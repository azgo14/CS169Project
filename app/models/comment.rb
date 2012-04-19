class Comment < ActiveRecord::Base

  belongs_to :video
  belongs_to :user

  def name
    if :anonymous
      return 'Anonymous'
    else
      return :user.email
    end
  end

end
