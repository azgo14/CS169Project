Feature: Moderating users as an admin
  As a BTP admin
  So that I may moderate membership
  I want to be able to block users from posting/commenting

Background: videos and comments submitted

  Given the following videos exist:
  | name                 | status   |
  | Mario                | accepted |
  
  And the following user exists:
  | email              | password  | blocked |
  | troll@api.com      | password  | false   |
  
  And the following comments exist:
  | anonymous | content    | video_id | user_id  | status  |
  | false      | You suck   | 1        | 1        | pending |



  And I am signed in as an administrator

Scenario: Clicking on a comentor's go to profile button redirects to the commenter's profile
  When I am on the admin comments page
  And I follow "Go to Profile"
  Then I should be on the the user profile page for "troll@api.com"

Scenario: Blocking a user
  Given I am on the user profile page for "troll@api.com"
  Then I should see "troll@api.com is allowed to post comments."
  When I press "block"
  Then I should see "troll@api.com is blocked from posting comments."

Scenario: Unblocking a user
  Given the following user exists:
  | email              | password  | blocked |
  | test@api.com       | password  | true    |
  And I am on the user profile page for "test@api.com"
  Then I should see "test@api.com is blocked from posting comments."
  When I press "unblock"
  Then I should see "test@api.com is allowed to post comments."
