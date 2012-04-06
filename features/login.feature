Feature: Registered Community Member
So that I may see the status of my digital story
I want to be able to login and see status and other information about my movie

Background: not logged in
 
  When I am not logged in
  And the following user exists:
    |  Username  |  Password   |  admin  |
    |  apiUser   |  abbtcs169  |  false  |
    |  adminAPI  |  cs169Admin |  true   |

  And the following user does not exist:
    |  Username  |  Password  |  admin   |
    |  fail_test |  fail_test |  false   |

  And the following videos have been submitted:
    | Name               | Email                 | Date Submitted | Status   |
    | Mario              | mario@plumber.com     | 09-Sept-1985   | Accepted |

Scenario: login successfully as a user
  Given I am on the home page
  When I follow "Login"
  And I am on the login page
  When I fill in the following:
    | Username   |  apiUser   |
    | Password   |  abbtcs169 |
 
  And I press "Login"
  Then I should be on the home page
  And I should see "Login Successful!"
  And I should not see "Admin Video Review"

Scenario: login successfully as an administrator
Given I am on the home page
  When I follow "Login"
  And I am on the login page
  When I fill in the following:
    | Username   |  adminAPI   |
    | Password   |  cs169Admin |
 
  And I press "Login"
  Then I should be on the home page
  And I should see "Login Successful!"
  And I should see "Admin Video Review"

Scenario: login unsuccessfully
  Given I am on the login page
  When I fill in the following:
    | Username   |  fail_test   |
    | Password   |  fail_test   |
  And I press "Login"
  Then I should be on the login page
  And I should see "Login Unsuccessful! Wrong Username or Password"

Scenario: commenting when not logged in
  Given I am on the video detail page for "Mario"
  Then I should see "Submit Comment Anonymously"
  And I should not see "Submit Comment"

Scenario: commenting when logged in
  Given I am signed in as a user
  And I am on the video detail page for "Mario"
  Then I should see "Submit Comment Anonymously"
  And I should see "Submit Comment"

Scenario: Upload a video anonymously
  Given I am on the home page
  And I follow "Upload"
  Then I am on the login page

  When I fill in the following:
    | Username   |  fail_test   |
    | Password   |  fail_test   |
 
  And I press "Login"
  Then I should be on the login page
  And I should see "Login Unsuccessful! Wrong Username or Password"

Scenario: Upload a video as a user
  Given I am on the home page
  And I follow "Upload"
  Then I am on the login page

  When I fill in the following:
    | Username   |  apiUser   |
    | Password   |  abbtcs169 |  
 
  And I press "Login"
  Then I should be on the video submission page
  And I should see "Login Successful!"