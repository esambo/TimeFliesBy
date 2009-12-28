Feature: Task Title

  In order to remember what I did
  As a daily end user
  I want to keep track of tasks by Start and Stop date-time, title and description

  Scenario: Create new task with title
    Given I am on the home page
    When I follow "Add Task"
    And I fill in "Title" with "My first task title"
    And I save the task
    Then I should see "Task saved successfully"
