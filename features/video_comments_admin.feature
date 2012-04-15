Feature: Moderating comments as an admin
  As a BTP admin
  So that I may monitor comments about stories
  I want to be able to view all recent comments and accept or reject them

Background: videos submitted

  Given the following videos have been submitted:
  | Name               | Email                 | Date Submitted | Status   |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | Accepted |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | Accepted |

  And the following comments have been submitted:
  | Name           | Content     | Video   | Date Submitted | Status   |
  | Some Troll     | You suck    | Mario   | 09-Sept-1985   | Rejected |
  | Nice Person    | Amazing     | Mario   | 21-July-2007   | Accepted |
  | New Person     | I am young  | Mario   | 01-July-2012   | Pending  |

  And I am signed in as an administrator

Scenario: Adding a comment adds a comment to the administrative interface
  When I am on the video list page
  And I follow "Harry Potter"
  And I fill in "Some Comment" in the "Comment" box
  And I click "Submit Comment"
  And I am on the admin/review page
  When I follow "Harry Potter"
  Then I should be on the admin/review page
  And I should see "Some Comment" under "Pending"

Scenario: Accepting a comment should update the admin display
  When I am on the admin/review page
  And I accept the comment "Amazing"
  Then I should be on the admin/review page
  And I should see "Amazing" under "Accepted"

Scenario: Rejecting a comment should update the admin display
  When I am on the admin/review page
  And I reject the comment "You suck"
  Then I should be on the admin/review page
  And I should see "You suck" under "Rejected"

Scenario: Accepting a comment should make a comment publicly visible
  When I am on the admin/review page
  And I accept the comment "Amazing"
  And I go to the page for "Mario"
  Then I should see "Amazing" under "Comments"

Scenario: Rejecting a comment should make a comment hidden
  When I am on the admin/review page
  And I reject the comment "You suck"
  And I go to the page for "Mario"
  Then I should not see "You suck" under "Comments"