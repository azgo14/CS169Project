Feature: User Messaging
As a registered community member
So that I may communicate with BTP admin staff
I want to be able to send messages/requests, etc

Background: 
  Given I set up accounts for messages because Devise is silly

Scenario: Send a message to admin
  Given I am signed in as an admin for messages
  Given I am on the home page
  When I follow "Messages"
  And I should not see "My Subject"

  Given I am not logged in
  Given I am signed in as a user for messages
  Given I am on the home page
  When I follow "Messages"
  Then I should be on the messages page

  When I follow "New Message"
  Then I should be on the new messages page
  When I fill in "subject" with "My Subject"
  When I fill in "message" with "My Message"
  And I press "Send"

  Given I am not logged in
  Given I am signed in as an admin for messages
  Given I am on the home page
  When I follow "Messages"
  And I should see "My Subject"
  And I should not see "My Message"
  When I follow "My Subject"
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
  And I am logged in as "apiUser@gmail.com"
  And this is not possible because Devise does not allow us to test like this
  When I follow "Messages"
  Then I should see "From Admin1"
  And I should see "From Admin2"
  And I should not see "To Admin1"
  And I should not see "To Admin2"
  And I should not see "From Admin3"
  And I should not see "To Admin3"
  When I follow "Sent Messages"
  Then I should see "To Admin1"
  And I should see "To Admin2"
  And I should not see "From Admin1"
  And I should not see "From Admin2"
  And I should not see "From Admin3"
  And I should not see "To Admin3"
  




