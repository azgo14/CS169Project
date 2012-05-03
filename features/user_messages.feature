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




