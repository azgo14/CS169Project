Feature: Viewing activity history
  As a registered community member
  So that I may view my site activity
  I want to be able to see all comments I have posted and messages sent

Background: videos and comments submitted
  Given the following videos exist:
  | name               | email                 | created_at     | status    | user_id  |
  | Commander Shephard | shephard@normandy.com | 06-March-2012  | pending   | 1        |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | accepted  | 2        |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | rejected  | 1        |
  And the following comments exist:
  | anonymous | content     | video_id | status   | user_id  |
  | false     | You suck    | 1        | rejected | 1        |
  | false     | Amazing     | 1        | accepted | 1        |
  | true      | I am young  | 1        | pending  | -1       |
  And the following messages exist:
  | from_user | subject | message |
  | 1         | hello   | testing |
  | 2         | wrong   | person  |
  | 1         | more    | stuff   |
  And I am signed in as user 1

Scenario: Viewing a profile displays all comment history
  When I go to the user profile page for user 1
  Then I should see the profile comment "You suck"
  And I should see the profile comment "Amazing"
  And I should not see the profile comment "I am young"

Scenario: Viewing a profile displays all message history
  When I go to the user profile page for user 1
  Then I should see the message "hello"
  And I should see the message "more"
  And I should not see the message "wrong"

Scenario: Posting a comment updates activity history
  When I go to the video detail page for "Mario"
  And I fill in "Comment" with "Some comment"
  And I press "Submit"
  And I go to the user profile page for user 1
  Then I should see the profile comment "Some comment"

Scenario: Sending a message updates activity history
  When I go to the new messages page
  And I fill in "Subject" with "testing"
  And I fill in "Message" with "something"
  And I press "Send"
  And I go to the user profile page for user 1
  Then I should see the message "testing"