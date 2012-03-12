Feature: video submission form

As an administrator of the Banyan Tree Project
So that members can share their personal stories and tell us about themselves
I want a video submission form that lets members upload their videos and provide some personal information

Scenario: upload a video
  Given I am on the video submission page
  When I fill in the following:
    | Name/Pseudonym                                                | Foo Baz      |
    | Email                                                         | foo@baz.com  |
    | Age                                                           | 9001         |
    | In what language is your story told?                          | Pig Latin    |
    | Location                                                      | Berkeley, CA |
    | Why did you want to tell this story?                          | Because.     |
    | How did telling your story change you?                        | Sad.         |
    | How do you hope hearing your story will change the community? | Improve      |
  And I check the following ethnicities: Chinese, Cambodian
  And I attach the file "video.avi" to "Upload Video"
  And I attach the file "image.jpeg" to "Upload Additional Video/Images"
  And I check "yes"
  When I press "Submit"
  Then I should be on the home page
  And I should see "Thank you for your submission!  We will be reviewing your story soon!"
  
