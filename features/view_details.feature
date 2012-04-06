Feature: View Details About a Story
  As an anonymous community member
  So that I can get more information on a particular story
  I want to be able to view details and other information about a story

Background: videos submitted

  Given the following videos exist:
  | name               | email                 | why           | how                       | status   |
  | Mario              | mario@plumber.com     | I'm a plumber | Because I save princesses | accepted |
  | Harry Potter       | potter@hogwarts.com   | I have a scar | I survived whatshisface   | accepted |

  And I am on the video list page

Scenario: Go from list to details page
  When I follow "Harry Potter"
  Then I should be on the video detail page for "Harry Potter"
  And I should see "I survived"
