Feature: Task stop validation
  >In order to have meaningful time tracking data  
  As a time tracking analyzer  
  I want to be certain that the stop is greater than start time  

  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: Validation error for stop before start
    Given I am on the new task page
    When I fill in "task_start" with "1/21/2010 8:38 PM"
    When I fill in "task_stop" with "1/21/2010 8:30 PM"
    And I press "Create"
    Then I should see "Stop needs to be greater than start."
  
