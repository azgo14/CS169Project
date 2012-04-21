class Video < ActiveRecord::Base

  serialize :ethnicity

  belongs_to :user
  has_many :comments

  SEARCH_OPTIONS = ["Title", "Ethnicity", "Age", "Location"]

  scope :search, (lambda do |search_text, search_condition|
                    where("lower(#{search_condition}) LIKE ?", "%#{search_text}%".downcase).order("name")
                  end)

  def self.yt_client
    yt_client = YouTubeIt::Client.new(:dev_key => 'AI39si6KxFUeYAkWUV5FVWzUThnJGb6PmeSdXOBa9MeKapONiggor24t22qsWmgRGzzWZuaqdQeeMVF8XBaWFDi-_XPgOayKLg', :username => 'testacct281', :password => 'testpass281')
    return yt_client
  end

  def self.upload(video)
    response = Video.yt_client.video_upload(video[:video], :title => video[:title],
                                           :description => video[:description],
                                           :list => 'denied', :comment => 'denied')
                                           # :private => '')
    yt_id = response.video_id[response.video_id.rindex(':')+1..-1]
    return yt_id
  end

  # def make_listed
  #   Video.yt_client.video_update(self.youtube_id, :list => 'allowed')
  # end

  # def make_unlisted
  #   Video.yt_client.video_update(self.youtube_id, :list => 'denied')
  # end

  def self.sort(status)
    Video.find(:all, :order => 'created_at DESC', :conditions => {:status => status})
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
