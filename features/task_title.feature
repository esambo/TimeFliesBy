Feature: Task Title

  In order to remember what I did
  As a daily end user
  I want to keep track of tasks

  Scenario: Create new task with title
    Given I am on the tasks page
    When I follow "New task"
    And I fill in "title" with "My first task title"
    And I press "Create"
    Then I should see "Task was successfully created."

  Scenario: Create a task with an empty title
    Given I am on the new task page
    When I press "Create"
    Then I should see "Task was successfully created."
 