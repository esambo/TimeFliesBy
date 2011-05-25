Feature: Tag
  >In order to categorize where I spend my time  
  As a person short on time  
  I want to tag my tasks  
  
  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: Create tag
    Given I am on the new tag page
    And I fill in "Education" for "tag_name"
    When I press "Create Tag"
    Then I should see "Tag was successfully created."
    And I should see "Education"
  
