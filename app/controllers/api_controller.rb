# Add a model to load this stuff soon
class VideoDummy
  attr_accessor :name, :why, :youtube_id, :how, :hope, :qa
end

class ApiController < ApplicationController
  def index
    # Messy code, but just hardcoded until we implement models
    a = VideoDummy.new
    b = VideoDummy.new
    c = VideoDummy.new
    a.name = 'Lance Toma'
    a.why = 'Lance Toma, Executive Director of Asian & Pacific Islander Wellness Center, was interviewed by Barbara Rodgers for Comcast Newsmakers. Lance talks about May 19, National Asian & Pacific Islander HIV/AIDS Awareness Day, how HIV-related stigma contributes to rising HIV rates in the A&PI community, and some of the commemoration events happening in the San Francisco Bay Area.'
    a.youtube_id = 'JZ5PEEeKGOo'
    b.name = 'James Kyson-Lee'
    b.why = 'James Kyson-Lee, one of the stars from NBC\'s "Heroes" sat down with the Banyan Tree Project for World AIDS Day. James wants the Asian & Pacific Islander community, especially A&PI youth, to learn the facts about HIV. We are all at risk, but we can protect ourselves with knowledge and action. Talk about HIV\-for you, for me, for everyone!'
    b.youtube_id = 'zN7u2VvehyQ'
    c.name = 'Kiran Ahuja'
    c.why = 'Kiran Ahuja is the Executive Director of the White House Initiative on Asian Americans and Pacific Islanders. She is responsible for directing the efforts of the White House Initiative and the Presidential Advisory Commission on AAPIs to advise federal agency leadership on the implementation and coordination of federal programs as they relate to AAPIs across executive departments and agencies. Kiran sat down with A&PI Wellness Center Executive Director Lance Toma to film a special message to the community for May 19.'
    c.youtube_id = '0NwxHphsCxI'

    @videos = [a,b,c]

    render :layout => 'api'
  end

  def show
    @video = VideoDummy.new
    @video.name = 'James Kyson-Lee'
    @video.why = 'James Kyson-Lee, one of the stars from NBC\'s "Heroes" sat down with the Banyan Tree Project for World AIDS Day. James wants the Asian & Pacific Islander community, especially A&PI youth, to learn the facts about HIV. We are all at risk, but we can protect ourselves with knowledge and action. Talk about HIV\-for you, for me, for everyone!'
    @video.youtube_id = 'zN7u2VvehyQ'
    @video.hope = @video.how = @video.qa = @video.why
    render :layout => 'api'
  end

  def submission
    render :layout => 'api'
  end

end
