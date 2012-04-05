class AddVideos < ActiveRecord::Migration

  lance_toma = 'Lance Toma, Executive Director of Asian & Pacific Islander Wellness Center, was interviewed by Barbara Rodgers for Comcast Newsmakers. Lance talks about May 19, National Asian & Pacific Islander HIV/AIDS Awareness Day, how HIV-related stigma contributes to rising HIV rates in the A&PI community, and some of the commemoration events happening in the San Francisco Bay Area.'
  james_kyson_lee = 'James Kyson-Lee, one of the stars from NBC\'s "Heroes" sat down with the Banyan Tree Project for World AIDS Day. James wants the Asian & Pacific Islander community, especially A&PI youth, to learn the facts about HIV. We are all at risk, but we can protect ourselves with knowledge and action. Talk about HIV\-for you, for me, for everyone!'
  kiran_ahuja = 'Kiran Ahuja is the Executive Director of the White House Initiative on Asian Americans and Pacific Islanders. She is responsible for directing the efforts of the White House Initiative and the Presidential Advisory Commission on AAPIs to advise federal agency leadership on the implementation and coordination of federal programs as they relate to AAPIs across executive departments and agencies. Kiran sat down with A&PI Wellness Center Executive Director Lance Toma to film a special message to the community for May 19.'
  VIDEOS = [
            {:name => 'Lance Toma', :why => lance_toma, :hope => lance_toma, :how => lance_toma, :qa => lance_toma, :youtube_id => 'JZ5PEEeKGOo', :email => 'lance_toma@api.com', :status => :pending},
            {:name => 'James Kyson-Lee', :why => james_kyson_lee, :hope => james_kyson_lee, :how => james_kyson_lee, :qa => james_kyson_lee, :youtube_id => 'zN7u2VvehyQ', :email => 'james_kyson-lee@api.com', :status => :accepted},
            {:name => 'Kiran Ahuja', :why => kiran_ahuja, :hope => kiran_ahuja, :how => kiran_ahuja, :qa => kiran_ahuja, :youtube_id => '0NwxHphsCxI', :email => 'kiran_ahuja@api.com', :status => :accepted}
            ]
  def up
    VIDEOS.each do |video|
      Video.create!(video)
    end
  end

  def down
    VIDEOS.each do |video|
      Video.find_by_youtube_id(video[:youtube_id]).destroy
    end
  end
end
