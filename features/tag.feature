Feature: tag
  In order to analyze where I spend my time
  As a person short on time
  I want to organize my tasks with tags
  
  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: create nested child tag
    Given I am on the new tag page
    And I fill in "USA" for "tag_name"
    When I press "Create Tag"
    Then the tag should be successfully created
  
  