Feature: Leaving comments on a video
  As a member of the Banyan Tree Project
  So that I can give my opinion on other members' personal stories
  I want to be able to leave comments on video submissions

Background: videos submitted

  Given the following videos have been submitted:
  | Name               | Email                 | Date Submitted | Status   |
  | Mario              | mario@plumber.com     | 09-Sept-1985   | Accepted |
  | Harry Potter       | potter@hogwarts.com   | 21-July-2007   | Accepted |

  And I am on the video list page

Scenario: Clicking on a video brings me to the detail page
  When I follow "Harry Potter"
  Then I should be on the video detail page for "Harry Potter"

Scenario: List of comments is initially empty
  When I follow "Harry Potter"
  Then I should not see any comments

Scenario: Adding a comment does not immediately add a comment to the detail page
  When I follow "Harry Potter"
  And I fill in "Some Comment" in the "Comment" box
  And I click "Submit Comment"
  Then I should not see "Some Comment"

Scenario: Adding a comment adds a comment to the administrative interface
  When I follow "Harry Potter"
  And I fill in "Some Comment" in the "Comment" box
  And I click "Submit Comment"
  When I am signed in as an administrator
  And I am on the admin/review page
  When I follow "Harry Potter"
  Then I should be on the admin/review page
  And I should see "Some Comment"

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
 




