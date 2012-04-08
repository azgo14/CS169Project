Feature: Sort Pending Movies
  As a BTP admin
  So that I may quickly find newly uploaded videos
  I want to see the pending videos sorted by date uploaded

Background: videos submitted

  Given the following videos exist:
  | name               | email                 | created_at     | status  |
  | Solid Snake        | snake@snake.com       | 12-June-2008   | pending |
  | Commander Shephard | shephard@normandy.com | 06-March-2012  | pending |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | pending |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | pending |

  And I am signed in as an administrator
  And I am on the admin/review page

Scenario: videos sorted by date uploaded
  Then I should see "Commander Shephard" before "Solid Snake"
  And I should see "Solid Snake" before "Harry Potter"
  And I should see "Harry Potter" before "Mario"

