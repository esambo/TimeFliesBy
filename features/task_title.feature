Feature: Task Title
  >In order to remember what I did  
  As a daily end user  
  I want to keep track of tasks  

  Background: Signed in
    Given I am signed in as a new user

  Scenario: Create new task with title
    Given I am on the tasks page
    When I follow "New Task"
    And I fill in all required fields
    And I fill in "task_title" with "My first task title"
    And I press "Create"
    Then I should see "Task was successfully created."

  Scenario: Create a task with an empty title
    Given I am on the new task page
    When I fill in all required fields
    And I fill in "task_title" with ""
    And I press "Create"
    Then I should see "Task was successfully created."
 