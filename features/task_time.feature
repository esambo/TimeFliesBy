Feature: Task Time
  >In order to reason about tasks performed  
  As a person reflecting on my time  
  I want to see the exact start and stop time of the task  

  Background: Signed in
    Given I am signed in as a new user

  Scenario: Create a task
    Given I am on the new task page
    When I fill in "task_start" with "12/28/2009 2:30 PM"
    And I fill in "task_stop" with "12/28/2009 2:31 PM"
    And I press "Create"
    Then I should see "Task was successfully created."
    And I should see "12/28/2009 14:30:00"
    And I should see "12/28/2009 14:31:00"

  Scenario: Require start when using "Create"
    Given I am on the new task page
    When I fill in "task_title" with "Bad test"
    And I press "Create"
    Then I should see "Start is not a valid datetime"

  Scenario: Update a task shows correct US time format
    Given I am on the new task page
    And I fill in "task_start" with "1/2/2011 2:30 PM"
    And I fill in "task_stop" with "1/2/2011 2:31 PM"
    And I press "Create"
    And I should see "Task was successfully created."
    And I follow "Edit"
    When I press "Update"
    Then I should see "Task was successfully updated."
    And I should see "1/2/2011 14:30:00"
    And I should see "1/2/2011 14:31:00"
