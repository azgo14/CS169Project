Given /the following videos exist/ do |videos_table|
  videos_table.hashes.each do |video|
    Video.create(video)
  end
end
