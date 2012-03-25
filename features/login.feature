Feature: Registered Community Member
So that I may see the status of my digital story
I want to be able to login and see status and other information about my movie

Background: not logged in
 
  Given I am on the home page
  And I am not logged in
  And the following user exists:
    |  Username  |  Password  |
    |  apiUser   |  abbtcs169 |

  And the following user does not exist:
    |  Username  |  Password  |
    |  fail_test |  fail_test |

Scenario: login successfully
  When I follow "Login"
  And I am on the login page
  When I fill in the following:
    | Username   |  apiUser   |
    | Password   |  abbtcs169 |
  And I press "Login"
  Then I should be on the home page
  And I should see "Login Successful!"

Scenario: login unsuccessfully
  When I follow "Login"
  And I am on the login page
  When I fill in the following:
    | Username   |  fail_test   |
    | Password   |  fail_test   |
  And I press "Login"
  Then I should be on the login page
  And I should see "Login Unsuccessful! Wrong Username or Password"

