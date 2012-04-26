Feature: Moderating users as an admin
  As a BTP admin
  So that I may moderate membership
  I want to be able to block users from posting/commenting

Background: videos and comments submitted

  Given the following videos have been submitted:
  | Name               | Email                 | Date Submitted | Status   |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | Accepted |

  And the following comments have been submitted:
  | Name           | Content     | Video   | Date Submitted | Status   |
  | Some Troll     | You suck    | Mario   | 09-Sept-1985   | Rejected |
  | Nice Person    | Amazing     | Mario   | 21-July-2007   | Accepted |
  | New Person     | I am young  | Mario   | 01-July-2012   | Pending  |

  And the following users exist
  | Name           | Email              | Password  | Blocked |
  | Some Troll     | troll@api.com      | password  | false   |
  | New Person     | noob@api.com       | password  | true    |

  And I am signed in as an administrator

Scenario: Clicking on a commenter's name redirects to the commenter's profile
  When I am on the admin/comments page
  And I follow "Some Troll"
  Then I should be on the the admin/user-profile page for "Some Troll"

Scenario: Blocking a user
  Given I am on the admin/user-profile page for "Some Troll"
  Then I should see "Some Troll is allowed to post comments."
  When I click "block"
  Then I should see "Some Troll is blocked from posting comments."

Scenario: Unblocking a user
  Given I am on the admin/user-profile page for "New Person"
  Then I should see "New Person is blocked from posting comments."
  When I click "unblock"
  Then I should see "New Person is allowed to post comments."
