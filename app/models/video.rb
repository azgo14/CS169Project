class Video < ActiveRecord::Base

  belongs_to :user
  has_many :comments

  def upload_to_youtube
  end

  def make_public
  end

  def make_private
  end 

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
