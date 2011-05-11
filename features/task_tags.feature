Feature: task tags
  In order to analyze where I spend my time
  As a person short on time
  I want to organize my tasks with tags
  
  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: add tags to new task
    Given I have the tags "Education, Read Book, BDD"
    And I am on the new task page
    And I check "Education"
    And I check "Read Book"
    When I press "Create Task"
    Then I should see "Education"
    And I should see "Read Book"
  
