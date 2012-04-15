Feature: As an anonymous community member
So that I may quickly find a digital story I like
I want to be able to search by title, ethnicity, age, location

Background: assuring existence of certain videos

  Given the following videos exist:
    | name         | age    | ethnicity   | location    | status   |
    | Mario Lui    | 21     | Chinese     | California  | Accepted |
    | Luigi Bo     | 25	    | Japanese    | New York    | Accepted |
    | Wario Joe    | 21     | Korean      | New Jersey  | Accepted |
    | Mike Slick   | 27	    | Cambodian   | Connecticut | Accepted |

Scenario: searching by full title (name) on the video list page
  Given that I am on the video list page
  When I select "Title" from search_conditions
  And I fill in "Mario Lui" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "Mario Lui" within "search_bar_text"
  And I should see "Title" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"

Scenario: searching by first name title (name) on the video list page
  Given that I am on the video list page
  When I select "Title" from search_conditions
  And I fill in "Mario" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "Mario" within "search_bar_text"
  And I should see "Title" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"
 
Scenario: searching by part of title (name) on the video list page
  Given that I am on the video list page
  When I select "Title" from search_conditions
  And I fill in "M" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "M" within "search_bar_text"
  And I should see "Title" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"

Scenario: fail searching by title on the video list page
  Given that I am on the video list page
  When I select "Title" from search_conditions
  And I fill in "Mer" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "Mer" within "search_bar_text"
  And I should see "Title" should be selected for "search_bar_condition"
  And I should see "There are no video(s) with Title: Mer"
  And I should not see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"

Scenario: searching by title with no text specified on the video list page
  Given that I am on the video list page
  When I select "Title" from search_conditions
  And I press "Search"
  Then I should be on the video search page
  And I should see "" within "search_bar_text"
  And I should see "Title" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should see "Mike Slick" within "search_results"
  And I should see "Wario Joe" within "search_results"
  And I should see "Luigi Bo" within "search_results"




Scenario: searching by full age on the video list page
  Given that I am on the video list page
  When I select "Age" from search_conditions
  And I fill in "25" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "25" within "search_bar_text"
  And I should see "Age" should be selected for "search_bar_condition"
  And I should not see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should see "Luigi Bo" within "search_results"

Scenario: fail searching by partial age on the video list page
  Given that I am on the video list page
  When I select "Age" from search_conditions
  And I fill in "2" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "2" within "search_bar_text"
  And I should see "Age" should be selected for "search_bar_condition"
  And I should see "There are no video(s) with Age: 2"
  And I should not see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"

Scenario: searching by age with no text specified on the video list page
  Given that I am on the video list page
  When I select "Age" from search_conditions
  And I press "Search"
  Then I should be on the video search page
  And I should see "" within "search_bar_text"
  And I should see "Age" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should see "Mike Slick" within "search_results"
  And I should see "Wario Joe" within "search_results"
  And I should see "Luigi Bo" within "search_results"



Scenario: searching by full ethnicity on the video list page
  Given that I am on the video list page
  When I select "Ethnicity" from search_conditions
  And I fill in "Cambodian" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "Cambodian" within "search_bar_text"
  And I should see "Ethnicity" should be selected for "search_bar_condition"
  And I should not see "Mario Lui" within "search_results"
  And I should see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"
 
Scenario: searching by part of ethnicity on the video list page
  Given that I am on the video list page
  When I select "Ethnicity" from search_conditions
  And I fill in "C" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "C" within "search_bar_text"
  And I should see "Ethnicity" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"

Scenario: fail searching by ethnicity on the video list page
  Given that I am on the video list page
  When I select "Ethnicity" from search_conditions
  And I fill in "Russian" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "Russian" within "search_bar_text"
  And I should see "Ethnicity" should be selected for "search_bar_condition"
  And I should see "There are no video(s) with Ethnicity: Russian"
  And I should not see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"

Scenario: searching by ethnicity with no text specified on the video list page
  Given that I am on the video list page
  When I select "Ethnicity" from search_conditions
  And I press "Search"
  Then I should be on the video search page
  And I should see "" within "search_bar_text"
  And I should see "Ethnicity" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should see "Mike Slick" within "search_results"
  And I should see "Wario Joe" within "search_results"
  And I should see "Luigi Bo" within "search_results"




Scenario: searching by full location on the video list page
  Given that I am on the video list page
  When I select "Location" from search_conditions
  And I fill in "New Jersey" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "New Jersey" within "search_bar_text"
  And I should see "Location" should be selected for "search_bar_condition"
  And I should not see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should  see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"
 
Scenario: searching by part of location on the video list page
  Given that I am on the video list page
  When I select "Location" from search_conditions
  And I fill in "New" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "New" within "search_bar_text"
  And I should see "Location" should be selected for "search_bar_condition"
  And I should not see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should see "Wario Joe" within "search_results"
  And I should see "Luigi Bo" within "search_results"

Scenario: fail searching by location on the video list page
  Given that I am on the video list page
  When I select "Location" from search_conditions
  And I fill in "Maine" for search_text
  And I press "Search"
  Then I should be on the video search page
  And I should see "Maine" within "search_bar_text"
  And I should see "Location" should be selected for "search_bar_condition"
  And I should see "There are no video(s) with Location: Maine"
  And I should not see "Mario Lui" within "search_results"
  And I should not see "Mike Slick" within "search_results"
  And I should not see "Wario Joe" within "search_results"
  And I should not see "Luigi Bo" within "search_results"

Scenario: searching by location with no text specified on the video list page
  Given that I am on the video list page
  When I select "Location" from search_conditions
  And I press "Search"
  Then I should be on the video search page
  And I should see "" within "search_bar_text"
  And I should see "Location" should be selected for "search_bar_condition"
  And I should see "Mario Lui" within "search_results"
  And I should see "Mike Slick" within "search_results"
  And I should see "Wario Joe" within "search_results"
  And I should see "Luigi Bo" within "search_results"