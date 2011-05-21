Feature: Task Description
  >In order to give a more detailed task description  
  As a daily end user  
  I want to enter long task descriptions that don't fit into the title  

  Background: Signed in
    Given I am signed in as a new user
    
  Scenario: Add task description
    Given I am on the new task page
    When I fill in all required fields
    And I fill in "task_description" with "A long task description explaining in more detail what the task is about"
    And I press "Create"
    Then I should see "Task was successfully created."
    And I should see "A long task description explaining"
