Feature: Upload a Video
  As an anonymous community member
  So that I can view and display my digital story on the BTP site
  I want to upload a file for BTP admin review and enter information about my movie

Scenario: uploading a video
  Given I am on the video list page
  Then I should see "Upload your video and share it with the world!"
  When I follow "Upload"
  Then I should be on the user sign-in page
  When I am signed in as a registered user,
  Then I should be on the video submission page

Scenario: filling in the video submission form
  Given I am signed in as a registered user,
  When I am on the video submission page
  When I fill in the following:
    | name     | Foo Baz      |
    | email    | foo@baz.com  |
    | age      | 9001         |
    | language | Pig Latin    |
    | location | Berkeley, CA |
    | title    | cool vid     |
    | about    | about me     |
    | why      | Because.     |
    | how      | Sad.         |
    | hope     | Improve      |
  And I check the following ethnicities: Chinese
  And I attach the file "spec/fixtures/files/test.mp4" to "Upload Your Story"
  When I press "Submit"
  Then I should be on the video list page
  And I should see "Thank you for your submission! We will be reviewing your story soon!"

