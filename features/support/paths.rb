# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the video\s? list page$/
      '/videos'
    when /^the video detail page for "([^"]+)"$/
      "/videos/#{Video.find_by_name($1).id}"
    when /^the user sign-out page$/
      '/users/sign_out'
    when /^the user sign-in page$/
      '/users/sign_in'
    when /^the video search page$/
      '/videos/search'
    when /^the admin videos page$/
      '/admin/videos'
    when /^the video submission page$/
      '/videos/new'
    when /^the admin comments page$/
      '/admin/comments'
    when /^the email page for "([^"]+)"$/
      "/admin/videos/email/#{Video.find_by_name($1).id}"
    when /^the user profile page for user ([0-9]*)$/
      "/users/#{$1}"
    when /^the new messages page$/
      '/messages/new'
    when /^the user profile page for "([^"]+)"$/
      "/users/#{User.find_by_email( $1 ).id}"



    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
