Feature: Moderating comments as an admin
  As a BTP admin
  So that I may monitor comments about stories
  I want to be able to view all recent comments and accept or reject them

Background: videos submitted

  Given the following videos exist:
  | name         | email               | created_at   | status   |
  | Mario        | mario@plumber.com   | 09-Sept-1985 | accepted |
  | Harry Potter | potter@hogwarts.com | 21-July-2007 | accepted |

  And the following comments exist:
  | user_id | content    | video_id | created_at   | status  |
  | 1       | You suck   | 1        | 09-Sept-1985 | pending |
  | 2       | Amazing    | 1        | 21-July-2007 | pending |
  | 3       | I am young | 1        | 01-July-2012 | pending |

  And I am signed in as an administrator

Scenario: Adding a comment adds a comment to the administrative interface
  When I am on the video list page
  And I follow "Harry Potter"
  And I fill in "Comment" with "Some Comment"
  And I press "Submit"
  And I am on the admin comments page
  And I should see "Some Comment" under "Pending"

Scenario: Accepting a comment should update the admin display
  When I am on the admin comments page
  And I accept comment 2
  Then I should be on the admin comments page
  And I should see "Amazing" under "Accepted"

Scenario: Rejecting a comment should update the admin display
  When I am on the admin comments page
  And I reject comment 1
  Then I should be on the admin comments page
  And I should see "You suck" under "Rejected"

Scenario: Accepting a comment should make a comment publicly visible
  When I am on the admin comments page
  And I accept comment 2
  And I go to the page for "Mario"
  Then I should see "Amazing" under "Comments"

Scenario: Rejecting a comment should make a comment hidden
  When I am on the admin comments page
  And I reject comment 1
  And I go to the page for "Mario"
  Then I should not see "You suck" under "Comments"
