class Comment < ActiveRecord::Base

  belongs_to :video
  belongs_to :user

  def name
    if anonymous or user.email == nil
      return 'Anonymous'
    else
      return user.email
    end
  end

  def self.sort(status)
    Comment.find(:all, :order => 'created_at DESC', :conditions => {:status => status})
  end

  def self.pending_comments
    sort(:pending)
  end

  def self.accepted_comments
    sort(:accepted)
  end

  def self.rejected_comments
    sort(:rejected)
  end

end
