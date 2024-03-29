Feature: Registered Community Member
So that I may see the status of my digital story
I want to be able to login and see status and other information about my movie

Background: not logged in

  When I am not logged in
  And the following user exists:
    |  email               |  password   |  admin  |
    |  apiUser@gmail.com   |  abbtcs169  |  false  |
    |  adminAPI@gmail.com  |  cs169Admin |  true   |

  And the following user does not exist:
    |  email               |  password  |  admin   |
    |  fail_test@gmail.com |  fail_test |  false   |

  And the following videos exist:
    | name                 | status   |
    | Mario                | accepted |

Scenario: login successfully as a user
  Given I am on the home page
  When I follow "Sign In"
  Then I should be on the user sign-in page

  When I fill in the following:
    | Email               |  apiUser@gmail.com   |
    | Password            |  abbtcs169  |

  And I press "Sign in"
  Then I should be on the home page
  And I should see "Signed in successfully."
  And I should not see "Admin Video Review"

Scenario: login successfully as an administrator
Given I am on the home page
  When I follow "Sign In"
  Then I should be on the user sign-in page

  When I fill in the following:
    | Email               |  adminAPI@gmail.com   |
    | Password            |  cs169Admin           |

  And I press "Sign in"
  Then I should be on the home page
  And I should see "Signed in successfully."
  And I should see "Admin Video Review"

Scenario: login unsuccessfully
  Given I am on the user sign-in page
  When I fill in the following:
    | Email                 |  fail_test@gmail.com    |
    | Password              |  fail_test              |
  And I press "Sign in"
  Then I should be on the user sign-in page
  And I should see "Invalid email or password."

Scenario: commenting when not logged in
  Given I am on the video detail page for "Mario"
  Then I should see "Submit Anonymously" button
  And I should not see "Submit" button

Scenario: commenting when logged in
  Given I am signed in as a user
  And I am on the video detail page for "Mario"
  Then I should see "Submit Anonymously" button
  And I should see "Submit" button

Scenario: Upload a video anonymously
  Given I am on the home page
  And I follow "Upload"

  Then I should be on the user sign-in page
  And I should see "You need to sign in or sign up before continuing."

  When I fill in the following:
    | Email                |  fail_test@gmail.com   |
    | Password             |  fail_test             |

  And I press "Sign in"
  Then I should be on the user sign-in page
  And I should see "Invalid email or password."

Scenario: Upload a video as a user
  Given I am on the home page
  And I follow "Upload"
  Then I should be on the user sign-in page
  And I should see "You need to sign in or sign up before continuing."
  When I fill in the following:
    | Email               |  apiUser@gmail.com |
    | Password            |  abbtcs169         |

  And I press "Sign in"
  Then I should be on the video submission page
  And I should see "Signed in successfully."


Scenario: Successful sign in from video details page
  Given I am on the video detail page for "Mario"
  When I follow "Sign In"
  Then I should be on the user sign-in page

  When I fill in the following:
    | Email               |  apiUser@gmail.com |
    | Password            |  abbtcs169         |

  And I press "Sign in"
  Then I should be on the video detail page for "Mario"
  And I should see "Signed in successfully."

Scenario: Non-admin user accessing admin video review page
  Given I am signed in as a user
  And I am on the admin videos page

  Then I should be on the home page
  And I should see "You must be an Admin to view this"

Scenario: Anonymous user accessing admin video review page and successfully logs in
  Given I am on the admin videos page

  Then I should be on the user sign-in page
  And I should see "You must be an Admin to view this"

  When I fill in the following:
    | Email               |  adminAPI@gmail.com   |
    | Password            |  cs169Admin           |

  And I press "Sign in"
  Then I should be on the admin videos page
  And I should see "Signed in successfully."

Scenario: Login out on non-authentication needed pages should allow user to stay on that page
  Given I am signed in as a user
  And I am on the video detail page for "Mario"

  When I am not logged in
  Then I should be on the video detail page for "Mario"
  And I should not see "Logout"

Scenario: Login out on authentication needed pages should cause redirect to sign in page
  Given I am signed in as a user
  And I am on the video submission page

  #this uses GET /users/sign_out, can't use DEL because we set signout to be GET in the initializer file for Devise
  When I am not logged in

  Then I should be on the user sign-in page
  And I should see "You need to sign in or sign up before continuing."