Feature:  As a BTP admin
  So that I may communicate with subscribers
  I want to be able to send messages to community members

Background: Existing users
  Given I set up accounts for messages because Devise is silly

Scenario: Admin drafts a new message
  Given I am signed in as an admin for messages
  Given I am on the home page
  When I follow "Messages"
  Then I should be on the messages page
  When I follow "New Message"
  Then I should be on the new message page

Scenario: See list of messages
  Given the following messages exist:
    | subject     | message | status | from_user | to_user |
    | To Admin1   | asdf    | read   | 123       | admin   |
    | From Admin1 | aeou    | read   | admin     | 123     |
    | To Admin2   | 1234    | unread | 123       | admin   |
    | From Admin2 | 5678    | unread | admin     | 123     |
    | To Admin3   | 1234    | unread | 234       | admin   |
    | From Admin3 | 5678    | unread | admin     | 234     |
  Given I am signed in as an admin for messages
  Given I am on the home page
  When I follow "Messages"
  Then I should see "To Admin1"
  And I should see "To Admin2"
  And I should see "To Admin3"
  And I should not see "From Admin1"
  And I should not see "From Admin2"
  And I should not see "From Admin3"
  When I follow "Sent Messages"
  Then I should see "From Admin1"
  And I should see "From Admin2"
  And I should see "From Admin3"
  And I should not see "To Admin1"
  And I should not see "To Admin2"
  And I should not see "To Admin3"
