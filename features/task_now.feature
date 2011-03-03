Feature: Task Now
  In order to quickly apply the unapplied time to the latest task
  As a daily end user
  I want to set the current date-time to the stop date-time

  Background: Signed in
    Given I am signed in as a new user
  
  @time_travel
  Scenario: Create a new task using 'Now' with having a previous task
    Given it is "1/3/2010 8:13:23 AM"
    And I have a one minute old task
    And I am on the new task page
    When I press "Now"
    Then I should see "Task was successfully created."
    And I should see "2010-01-03 08:12:23 -0600"
    And I should see "2010-01-03 08:13:23 -0600"

  @time_travel
  Scenario: Create a new task using 'Now' without having a previous task
    Given it is "1/3/2010 8:13:23 AM"
    And I am on the new task page
    When I press "Now"
    Then I should see "Task was successfully created."
    And I should see "2010-01-03 08:13:23 -0600"

  @time_travel
  Scenario: 'Now' on edit task
    Given it is "1/3/2010 8:13:23 AM"
    And I have a one minute old task
    And I am on the tasks page
    And I follow "Edit"
    Then I press "Now"
    Then I should see "Task was successfully updated."
    And I should see "2010-01-03 08:13:23 -0600"
