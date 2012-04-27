Feature: As a BTP admin
  So that I may investigate issues with a story and keep storytellers informed of their story's status
  I want to be able to send an email to storytellers while their story is pending

Background: videos submitted

  Given the following videos exist:
  | name            | email            | status   |
  | Professor Oak   | oak@oaks_lab.com | pending  |
  
  And I am signed in as an administrator
  And I am on the admin video detail page for "Professor Oak"

Scenario: Sending an email
  When I press "Email Storyteller"
  Then I should be on the email page
  And "to" should contain "oak@oaks_lab.com"
  And "subject" should contain "Questions about your Taking Root story submission"
  And "message" should be empty
  When I fill in "message" with "What is your favorite starter Pokemon?"
  And I press "Send"
  Then I should be on the admin video detail page for "Professor Oak"
  And I should see "Your email has been sent."

Scenario: Cancel sending an email
  When I press "Email Storyteller"
  And I press "Cancel"
  Then I should be on the admin video detail page for "Professor Oak"
  And I should not see "Your email has been sent."

Scenario: Changing pre-entered fields
  When I press "Email Storyteller"
  And I fill in "to" with "profs_aid@oaks_lab.com"
  And I fill in "subject" with "Professor Oak's Submission"
  And I fill in "message" with "What is Professor Oak's favorite Pokemon?"
  And I press "Send"
  Then I should be on the admin video detail page for "Professor Oak"
  And I should see "Your email has been sent."


