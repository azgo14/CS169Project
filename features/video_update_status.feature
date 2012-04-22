Feature: Update Video Status
  As a BTP admin
  So that I can approve digital stories for display on the BTP site
  I want to be able to view individual digital stories and approve/reject/mark them pending

Background: videos submitted

  Given the following videos exist:
  | name               | email                 | created_at     | status    |
  | Solid Snake        | snake@snake.com       | 12-June-2008   | pending   |
  | Commander Shephard | shephard@normandy.com | 06-March-2012  | pending   |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | accepted  |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | rejected  |

  And I am signed in as an administrator
  And I am on the admin videos page

Scenario: Videos should be partitioned by status (pending, accepted, rejected) and sorted by date submitted
  Then I should see the following under "Pending": Solid Snake, Commander Shephard
  And I should see "Commander Shephard" before "Solid Snake"
  And I should see the following under "Accepted": Mario
  And I should see the following under "Rejected": Harry Potter

Scenario: Clicking on a video brings me to the admin detail page
  When I follow "Solid Snake"
  Then I should be on the admin video detail page for "Solid Snake"

Scenario: Accept a pending video
  Given I am on the admin video detail page for "Solid Snake"
  When I press "Accept"
  Then I should be on the admin video detail page for "Solid Snake"
  And I should see "This video has been accepted."
  When I am on the admin videos page
  Then I should see the following under "Accepted": Mario, Solid Snake
  And I should see "Solid Snake" before "Mario"

Scenario: Reject a pending video
  Given I am on the admin video detail page for "Solid Snake"
  When I press "Reject"
  Then I should be on the admin video detail page for "Solid Snake"
  And I should see "This video has been rejected."
  When I am on the admin videos page
  Then I should see the following under "Rejected": Harry Potter, Solid Snake

Scenario: Reject an accepted video
  Given I am on the admin video detail page for "Mario"
  When I press "Reject"
  Then I should be on the admin video detail page for "Mario"
  And I should see "This video has been rejected."
  When I am on the admin videos page
  Then I should see the following under "Rejected": Harry Potter, Mario

Scenario: Accept a rejected video
  Given I am on the admin video detail page for "Harry Potter"
  When I press "Accept"
  Then I should be on the admin video detail page for "Harry Potter"
  And I should see "This video has been accepted."
  When I am on the admin videos page
  Then I should see the following under "Accepted": Mario, Harry Potter

