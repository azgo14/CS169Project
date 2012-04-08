Feature: Upload a Video
  As an anonymous community member
  So that I can view and display my digital story on the BTP site
  I want to upload a file for BTP admin review and enter information about my movie

Scenario: uploading a video
  Given I am on the home page
  Then I should see "Upload your video and share it with the world!"
  When I follow "Upload"
  Then I should be on the video submission page

Scenario: filling in the video submission form
  Given I am on the video submission page
  When I fill in the following:
    | name     | Foo Baz      |
    | email    | foo@baz.com  |
    | age      | 9001         |
    | language | Pig Latin    |
    | location | Berkeley, CA |
    | why      | Because.     |
    | how      | Sad.         |
    | hope     | Improve      |
  And I check the following ethnicities: Chinese
  And I attach the file "features/video_upload.feature" to "Upload Video"
  #And I attach the file "video_upload.feature" to "Additional Video/Images"
  And I choose "release_true"
  When I press "Submit"
  Then I should be on the video list page
  And I should see "Thank you for your submission! We will be reviewing your story soon!"
  
