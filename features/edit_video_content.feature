Feature: Edit Video Content
As a BTP admin
So that I may ensure the quality of related video text content (answers to canned questions, title, story background info, etc) meets our standards
I want to be able to edit content in video text fields

Background: videos submitted

  Given the following videos exist:
  | name        | email           | created_at   | status  | title | about      | why     | how       | hope     |
  | Solid Snake | snake@snake.com | 12-June-2008 | pending | MGS   | video game | because | it didn't | it won't |

  And I am signed in as an administrator
  Given I am on the admin video detail page for "Solid Snake"

Scenario: Video detail page should display orginal text content from submitter
  Then the "video_title" field should contain "MGS"
  And the "video_about" field should contain "video game"
  And the "video_why" field should contain "because"
  And the "video_how" field should contain "it didn't"
  And the "video_hope" field should contain "it won't"

Scenario: Editing the text content of a video
  When I fill in the following:
  | video_title        | Metal Gear Solid                |
  | video_about        | stealth                         |
  | video_how          | made me a better spy            |
  | video_hope         | raise awareness about espionage |
  And I press "Save changes"
  Then I should be on the admin video detail page for "Solid Snake"
  And I should see "This video has been successfully updated"
  And the "video_title" field should contain "Metal Gear Solid"
  And the "video_about" field should contain "stealth"
  And the "video_why" field should contain "because"
  And the "video_how" field should contain "made me a better spy"
  And the "video_hope" field should contain "raise awareness about espionage"
