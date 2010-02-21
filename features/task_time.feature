Feature: Task Time
  In order to see when a task was performed
  As a troubleshooting user
  I want to see the start date-time and stop date-time of a task

  Background: Signed in
    Given I am signed in as a new user

  Scenario: Create a task
    Given I am on the new task page
    When I fill in "start" with "12/28/2009 2:30 PM"
    And I fill in "stop" with "12/28/2009 2:31 PM"
    And I press "Create"
    Then I should see "Task was successfully created."

  Scenario: Require start and stop time
    Given I am on the new task page
    When I fill in "title" with "Bad test"
    And I press "Create"
    Then I should see "Start can't be blank"

