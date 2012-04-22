Given /the following comments exist/ do |t|
  t.hashes.each do |c|
    #c.video = Video.find_by_title(c.video_id)
    Comment.create(c)
  end
end
