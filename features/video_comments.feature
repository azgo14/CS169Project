Feature: Leaving comments on a video
  As an anonymous community member
  So that I may interact with stories I like
  I want to be able to rate stories and leave comments for other storytellers

Background: videos submitted

  Given the following videos have been submitted:
  | Name               | Email                 | Date Submitted | Status   |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | Accepted |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | Accepted |

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
  And I fill in "Some Comment" in the "Comment" box
  And I click "Submit Comment"
  Then I should not see "Some Comment"

Scenario: Cannot post comments as an blocked user
  When I follow "Logout"
  And I am signed in as a registered, blocked user
  And I am on the video list page
  When I follow "Harry Potter"
  And I fill in "Please unblock me" in the "Comment" box
  And I click "Submit Comment"
  Then I should not see "Please unblock me"
  But I should see "Sorry, you are not allowed to post comments"

Scenario: Only see accepted comments
 Given the following comments have been submitted:
   | Name           | Content     | Video   | Date Submitted | Status   |
   | Some Troll     | You suck    | Mario   | 09-Sept-1985   | Rejected |
   | Nice Person    | Amazing     | Mario   | 21-July-2007   | Accepted |
   | New Person     | I am young  | Mario   | 01-July-2012   | Pending  |
 And I am on the video detail page for "Mario"

 Then I should not see "You suck"
 And I should see "Amazing
 And I should not see "I am young"
