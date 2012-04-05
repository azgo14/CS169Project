class Video < ActiveRecord::Base

  serialize :ethnicity

  belongs_to :user
  has_many :comments

  def self.sort(status)
    Video.find(:all, :order => :submission_date, :conditions => {:status => status})
  end

  def self.pending_videos
    sort(:pending)
  end

  def self.accepted_videos
    sort(:accepted)
  end

  def self.rejected_videos
    sort(:rejected)
  end

end
