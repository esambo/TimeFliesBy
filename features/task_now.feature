Feature: Task Now
  In order to quickly apply the unapplied time to the latest task
  As a daily end user
  I want to set the current date-time to the stop date-time

  Scenario: Create a new task using 'Now' with having a previous task
    Given I have a task
    And I am on the new task page
    When I press "Now"
    Then I should see "Task was successfully created."

  Scenario: Create a new task using 'Now' without having a previous task
    Given I am on the new task page
    When I press "Now"
    Then I should see "No previous task was found! Please check the start time."

  Scenario: 'Now' on edit task
    Given I have a task
    And I am on the tasks page
    And I follow "edit"
    When I press "Now"
    Then I should see "Task was successfully updated."
