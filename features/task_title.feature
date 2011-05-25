Feature: Task Title
  >In order to remember what I did  
  As a person short on time  
  I want to keep track of tasks  

  Background: Signed in
    Given I am signed in as a new user

  Scenario: Create new task with title
    Given I am on the new task page
    And I fill in all required fields
    And I fill in "task_title" with "My first task title"
    When I press "Create"
    Then I should see "Task was successfully created."
    And I should see "My first task title"
  
