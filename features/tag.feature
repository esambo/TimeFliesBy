Feature: Tag
  >In order to analyze where I spend my time  
  As a person short on time  
  I want to maintain my own tags  
  
  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: Create tag
    Given I am on the new tag page
    And I fill in " Education" for "tag_name"
    When I press "Create Tag"
    Then the tag should be successfully created
    And I should see "Education"
  
