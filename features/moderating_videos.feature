Feature: Sorted video submissions by status on the admin page
  As an administrator of the Banyan Tree Project
  So that I can keep track of video submissions
  I want to see videos sorted by their status (pending, accepted, or rejected) and submission date

Background: videos submitted

  Given the following videos have been submitted:
  | Name               | Email                 | Date Submitted | Status   |
  | Solid Snake        | snake@snake.com       | 12-June-2008   | Pending  |
  | Commander Shephard | shephard@normandy.com | 06-March-2012  | Rejected |
  | Garrus Vakarian    | garrus@normandy.com   | 06-March-2012  | Pending  |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | Accepted |
  | Captain America    | america@heroes.com    | 04-July-1776   | Rejected |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | Accepted |

  And I am signed in as an administrator
  And I am on the admin/review page

Scenario: videos sorted by status (pending, accepted, rejected), then submission date
  Then I should see "Garrus Vakarian" before "Solid Snake"
  And I should see "Solid Snake" before "Harry Potter"
  And I should see "Harry Potter" before "Mario"
  And I should see "Mario" before "Commander Shephard"
  And I should see "Commander Shephard" before "Captain America"

Scenario: accepting a pending movie
  When I follow "Garrus Vakarian"
  Then I should be on the admin detail page
  When I press "Accepted"
  Then I should be on the admin/review page
  Then I should see "Solid Snake" before "Garrus Vakarian"
  And I should see "Garrus Vakarian" before "Harry Potter"
  And I should see "Harry Potter" before "Mario"
  And I should see "Mario" before "Commander Shephard"
  And I should see "Commander Shephard" before "Captain America"

Scenario: rejecting a pending movie
  When I follow "Garrus Vakarian"
  Then I should be on the admin detail page
  When I press "Rejected"
  Then I should be on the admin/review page
  Then I should see "Solid Snake" before "Harry Potter"
  And I should see "Harry Potter" before "Mario"
  And I should see "Commander Shephard" before "Garrus Vakarian"
  And I should see "Garrus Vakarian" before "Captian America"
