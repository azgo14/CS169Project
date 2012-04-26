Feature: Video Notes Field
  As a BTP admin
  So that I may leave a record of my thoughts and communicate status of stories with other admins
  I want to be able to enter info into a notes field associated with each submitted story

Background: videos submitted
  Given the following videos exist:
  | name               | email                 | created_at     | status    | notes        |
  | Commander Shephard | shephard@normandy.com | 06-March-2012  | pending   |              |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | accepted  | Touching     |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | rejected  | Not relevant |

  And I am signed in as an administrator

Scenario: Notes should be initially empty for a new submission
  Given I am on the admin video detail page for "Commander Shephard"
  Then I should not see any notes

Scenario: Entering notes
  Given I am on the admin video detail page for "Commander Shephard"
  When I fill in "video_notes" with "Great story!"
  And I press "Save changes"
  Then I should be on the admin video detail page for "Commander Shephard"
  And the "video_notes" field should contain "Great story!"

Scenario: "Notes" field should be filled in if a video already has notes
  Given I am on the admin video detail page for "Mario"
  Then the "video_notes" field should contain "Touching"
  Given I am on the admin video detail page for "Harry Potter"
  Then the "video_notes" field should contain "Not relevant"

