Feature: As an anonymous community member
So that I may quickly find a digital story I like
I want to be able to search by title, ethnicity, age, location

Background: assuring existence of certain videos

  Given the following videos exist:
    | name         | age    | ethnicity   | location    | status   |
    | Mario Lui    | 21     | Chinese     | California  | accepted |
    | Luigi Bo     | 25	    | Japanese    | New York    | accepted |
    | Wario Joe    | 21     | Korean      | New Jersey  | accepted |
    | Mike Slick   | 27	    | Cambodian   | Connecticut | accepted |

Scenario: Entering search text w/o selecting condition (default to title)
  Given I am on the video list page
  And I fill in "Mario Lui" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "Mario Lui"
  And I should see "Title" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"
 
Scenario: searching by full title (name) on the video list page
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I fill in "Mario Lui" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "Mario Lui"
  And I should see "Title" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: searching by first name title (name) on the video list page
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I fill in "Mario" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "Mario"
  And I should see "Title" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"
 
Scenario: searching by part of title (name) on the video list page
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I fill in "M" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "M"
  And I should see "Title" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Mario Lui" before "Mike Slick"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: fail searching by title on the video list page
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I fill in "Mer" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "Mer"
  And I should see "Title" should be selected for "search_condition"
  And I should see /There are no video\(s\) with "Title": "Mer"/
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: searching by title with no text specified on the video list page
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain ""
  And I should see "Title" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Wario Joe" within "#search_results"
  And I should see "Luigi Bo" within "#search_results"
  And I should see "Luigi Bo" before "Mario Lui"
  And I should see "Mario Lui" before "Mike Slick"
  And I should see "Mike Slick" before "Wario Joe"



Scenario: searching by full age on the video list page
  Given I am on the video list page
  When I select "Age" from "search_condition"
  And I fill in "25" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "25"
  And I should see "Age" should be selected for "search_condition"
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should see "Luigi Bo" within "#search_results"

Scenario: searching by partial age that doesn't exist on the video list page
  Given I am on the video list page
  When I select "Age" from "search_condition"
  And I fill in "3" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "3"
  And I should see "Age" should be selected for "search_condition"
  And I should see /There are no video\(s\) with "Age": "3"/
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: searching by partial age that does exist on the video list page
  Given I am on the video list page
  When I select "Age" from "search_condition"
  And I fill in "2" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "2"
  And I should see "Age" should be selected for "search_condition"
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: searching by age with no text specified on the video list page
  Given I am on the video list page
  When I select "Age" from "search_condition"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain ""
  And I should see "Age" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Wario Joe" within "#search_results"
  And I should see "Luigi Bo" within "#search_results"
  And I should see "Luigi Bo" before "Mario Lui"
  And I should see "Mario Lui" before "Mike Slick"
  And I should see "Mike Slick" before "Wario Joe"


Scenario: searching by full ethnicity on the video list page
  Given I am on the video list page
  When I select "Ethnicity" from "search_condition"
  And I fill in "Cambodian" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "Cambodian"
  And I should see "Ethnicity" should be selected for "search_condition"
  And I should not see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"
 
Scenario: searching by part of ethnicity on the video list page
  Given I am on the video list page
  When I select "Ethnicity" from "search_condition"
  And I fill in "C" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "C"
  And I should see "Ethnicity" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Mario Lui" before "Mike Slick"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: fail searching by ethnicity on the video list page
  Given I am on the video list page
  When I select "Ethnicity" from "search_condition"
  And I fill in "Russian" for "search_text"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain "Russian"
  And I should see "Ethnicity" should be selected for "search_condition"
  And I should see /There are no video\(s\) with "Ethnicity": "Russian"/
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: searching by ethnicity with no text specified on the video list page
  Given I am on the video list page
  When I select "Ethnicity" from "search_condition"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain ""
  And I should see "Ethnicity" should be selected for "search_condition"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Wario Joe" within "#search_results"
  And I should see "Luigi Bo" within "#search_results"
  And I should see "Luigi Bo" before "Mario Lui"
  And I should see "Mario Lui" before "Mike Slick"
  And I should see "Mike Slick" before "Wario Joe"


@javascript
Scenario: searching by full location on the video list page
  Given I am on the video list page
  When I select "Location" from "search_condition"
  And I select "New Jersey" from "search_text"
  And I press "Search"
  Then I should be on the video search page  
  And I should see "New Jersey" should be selected for "search_text"
  And I should see "Location" should be selected for "search_condition"
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

@javascript
Scenario: fail searching by location on the video list page
  Given I am on the video list page
  When I select "Location" from "search_condition"
  And I select "Maine" from "search_text"
  And I press "Search"
  Then I should be on the video search page
  And I should see "Maine" should be selected for "search_text"
  And I should see "Location" should be selected for "search_condition"
  And I should see /There are no video\(s\) with "Location": "Maine"/
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"

Scenario: searching by location with no text specified on the video list page
  Given I am on the video list page
  When I select "Location" from "search_condition"
  And I press "Search"
  Then I should be on the video search page
  And I should see "Location" should be selected for "search_condition"
  And I should see "" should be selected for "search_text"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Wario Joe" within "#search_results"
  And I should see "Luigi Bo" within "#search_results"
  And I should see "Luigi Bo" before "Mario Lui"
  And I should see "Mario Lui" before "Mike Slick"
  And I should see "Mike Slick" before "Wario Joe"

Scenario: more videos in returned by search than 5 which causes pagination
  Given the following videos exist:
    | name         | age    | ethnicity   | location    | status   |
    | Abe Jo       | 19     | Chinese     | California  | accepted |
    | Bob Elo      | 18	    | Japanese    | New York    | accepted |
    | Chang So     | 25     | Korean      | New Jersey  | accepted |
    | Darren Go    | 27	    | Cambodian   | Connecticut | accepted |
    | Elen Cer     | 32     | Chinese     | Georgia     | accepted |
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain ""
  And I should see "Title" should be selected for "search_condition"
  And I should see "Abe Jo" within "#search_results"
  And I should see "Bob Elo" within "#search_results"
  And I should see "Chang So" within "#search_results"
  And I should see "Darren Go" within "#search_results"
  And I should see "Elen Cer" within "#search_results"
  And I should see "Abe Jo" before "Bob Elo"
  And I should see "Bob Elo" before "Chang So"
  And I should see "Chang So" before "Darren Go"
  And I should see "Darren Go" before "Elen Cer" 
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"
  
  When I follow "Next"
  And I should not see "Abe Jo" within "#search_results"
  And I should not see "Bob Elo" within "#search_results"
  And I should not see "Chang So" within "#search_results"
  And I should not see "Darren Go" within "#search_results"
  And I should not see "Elen Cer" within "#search_results"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Wario Joe" within "#search_results"
  And I should see "Luigi Bo" within "#search_results"
  And I should see "Luigi Bo" before "Mario Lui"
  And I should see "Mario Lui" before "Mike Slick"
  And I should see "Mike Slick" before "Wario Joe"

Scenario: pressing next and then prev for paginated search
 Given the following videos exist:
    | name         | age    | ethnicity   | location    | status   |
    | Abe Jo       | 19     | Chinese     | California  | accepted |
    | Bob Elo      | 18	    | Japanese    | New York    | accepted |
    | Chang So     | 25     | Korean      | New Jersey  | accepted |
    | Darren Go    | 27	    | Cambodian   | Connecticut | accepted |
    | Elen Cer     | 32     | Chinese     | Georgia     | accepted |
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain ""
  And I should see "Title" should be selected for "search_condition"
  And I should see "Abe Jo" within "#search_results"
  And I should see "Bob Elo" within "#search_results"
  And I should see "Chang So" within "#search_results"
  And I should see "Darren Go" within "#search_results"
  And I should see "Elen Cer" within "#search_results"
  And I should see "Abe Jo" before "Bob Elo"
  And I should see "Bob Elo" before "Chang So"
  And I should see "Chang So" before "Darren Go"
  And I should see "Darren Go" before "Elen Cer" 
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  
  When I follow "Next"
  And I follow "Prev"
  Then I should be on the video search page
  And the "search_text" field should contain ""
  And I should see "Title" should be selected for "search_condition"
  And I should see "Abe Jo" within "#search_results"
  And I should see "Bob Elo" within "#search_results"
  And I should see "Chang So" within "#search_results"
  And I should see "Darren Go" within "#search_results"
  And I should see "Elen Cer" within "#search_results"
  And I should see "Abe Jo" before "Bob Elo"
  And I should see "Bob Elo" before "Chang So"
  And I should see "Chang So" before "Darren Go"
  And I should see "Darren Go" before "Elen Cer" 
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"

Scenario: more videos in returned by search than 5 which causes pagination. Instead of pressing next, we press last.

  Given the following videos exist:
    | name         | age    | ethnicity   | location    | status   |
    | Abe Jo       | 19     | Chinese     | California  | accepted |
    | Bob Elo      | 18	    | Japanese    | New York    | accepted |
    | Chang So     | 25     | Korean      | New Jersey  | accepted |
    | Darren Go    | 27	    | Cambodian   | Connecticut | accepted |
    | Elen Cer     | 32     | Chinese     | Georgia     | accepted |
  Given I am on the video list page
  When I select "Title" from "search_condition"
  And I press "Search"
  Then I should be on the video search page
  And the "search_text" field should contain ""
  And I should see "Title" should be selected for "search_condition"
  And I should see "Abe Jo" within "#search_results"
  And I should see "Bob Elo" within "#search_results"
  And I should see "Chang So" within "#search_results"
  And I should see "Darren Go" within "#search_results"
  And I should see "Elen Cer" within "#search_results"
  And I should see "Abe Jo" before "Bob Elo"
  And I should see "Bob Elo" before "Chang So"
  And I should see "Chang So" before "Darren Go"
  And I should see "Darren Go" before "Elen Cer" 
  And I should not see "Mario Lui" within "#search_results"
  And I should not see "Mike Slick" within "#search_results"
  And I should not see "Wario Joe" within "#search_results"
  And I should not see "Luigi Bo" within "#search_results"
  
  When I follow "Last"
  And I should not see "Abe Jo" within "#search_results"
  And I should not see "Bob Elo" within "#search_results"
  And I should not see "Chang So" within "#search_results"
  And I should not see "Darren Go" within "#search_results"
  And I should not see "Elen Cer" within "#search_results"
  And I should see "Mario Lui" within "#search_results"
  And I should see "Mike Slick" within "#search_results"
  And I should see "Wario Joe" within "#search_results"
  And I should see "Luigi Bo" within "#search_results"
  And I should see "Luigi Bo" before "Mario Lui"
  And I should see "Mario Lui" before "Mike Slick"
  And I should see "Mike Slick" before "Wario Joe"
