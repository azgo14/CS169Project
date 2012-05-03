Feature: Leaving comments on a video
  As an anonymous community member
  So that I may interact with stories I like
  I want to be able to rate stories and leave comments for other storytellers

Background: videos submitted

  Given the following videos exist:
  | name               | email                 | status   |
  | Mario              | mario@plumber.com     | accepted |
  | Harry Potter       | potter@hogwarts.com   | accepted |

  And I am signed in as a registered user
  And I am on the video list page

Scenario: Clicking on a video brings me to the detail page
  When I follow "Harry Potter"
  Then I should be on the video detail page for "Harry Potter"

Scenario: List of comments is initially empty
  When I follow "Harry Potter"
  Then I should not see any comments

Scenario: Posting a comment as an unblocked user does not immediately add a comment to the detail page
  When I follow "Harry Potter"
  And I fill in "Anonymous Comment" with "Some Comment"
  And I press "Submit Anonymously"
  Then I should not see "Some Comment"

Scenario: Cannot post comments as an blocked user
  When I am signed in as a blocked user
  And I am on the video list page
  When I follow "Harry Potter"
  And I fill in "Anonymous Comment" with "Please unblock me"
  And I press "Submit Anonymously"
  Then I should see "Sorry, you are not allowed to post comments"

Scenario: Only see accepted comments
  And the following comments exist:
  | anonymous | content     | video_id | status   |
  | true      | You suck    | 1        | rejected |
  | true      | Amazing     | 1        | accepted |
  | true      | I am young  | 1        | pending  |
  When I follow "Mario"
  Then I should not see "You suck"
  And I should see "Amazing"
  And I should not see "I am young"
