Feature:  As a BTP admin
  So that I may communicate with subscribers
  I want to be able to send messages to community members

Background: Existing users
  Given the following users exist:
   | email                 | password   | admin   | id |
   | user@api.com          | password   | false   | 1  |
   | admin@api.com	       | password   | true    | 2  |
   And I am logged in as admin@api.com

Scenario: Admin drafts a new message
  Given I am on the home page
  When I follow "Messages"
  Then I should be on the messages page
  When I follow "New Message"
  Then I should be on the new message page

Scenario: Admin sends a message
  Given I am on the new message page
  When I fill in "to" with "user@api.com"
  And I fill in "subject" with "My Subject"
  And I fill in "message" with "My Message"
  And I press "send"
  Then I should be on the messages page
  And I should see "Your message has been sent."

  Given I am on the user profile page for "user@api.com"
  When I fill in "subject" with "This is a test"
  And I fill in "body" with "Hello world!"
  And I press "send"
  Then I should be on the user profile page for "user@api.com"
  And I should see "Your message to user@api.com has been sent."

  Given I am logged in as "user@api.com"
  When I follow "Messages"
  Then I should see "admin@api.com"
  And I should see "My Subject"
  When I follow "My Subject"
  Then I should be on the message detail page
  And I should see "admin@api.com"
  And I should see "My Subject"
  And I should see "My Message"

Scenario: See list of messages
  Given the following messages exist:
    | subject     | message | status | from_user | to_user |
    | To Admin1   | asdf    | read   | 123       | admin   |
    | From Admin1 | aeou    | read   | admin     | 123     |
    | To Admin2   | 1234    | unread | 123       | admin   |
    | From Admin2 | 5678    | unread | admin     | 123     |
    | To Admin3   | 1234    | unread | 234       | admin   |
    | From Admin3 | 5678    | unread | admin     | 234     |
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
