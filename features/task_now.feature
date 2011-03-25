Feature: Task Now
  In order to quickly apply the unapplied time to the latest task
  As a time tracker
  I want to set the current date-time to the stop date-time
  
  Background: Signed in
    Given I am signed in as a new user
  
  @time_travel
  Scenario: First new task using 'Now'
    Given it is "1/3/2010 8:13:23 AM"
    And I have a one minute old task
    And I am on the new task page
    When I press "Now"
    Then I should see "Task was successfully created."
    And I should see "1/3/2010 08:12:23"
    And I should see "1/3/2010 08:13:23"
  
  @time_travel
  Scenario: New task using 'Now'
    Given it is "1/3/2010 8:13:23 AM"
    And I am on the new task page
    When I press "Now"
    Then I should see "Task was successfully created."
    And I should see "1/3/2010 08:13:23"
  
  @time_travel
  Scenario: 'Now' on edit task
    Given it is "1/3/2010 8:13:23 AM"
    And I have a one minute old task
    And I am on the tasks page
    And I follow "Edit"
    Then I press "Now"
    Then I should see "Task was successfully updated."
    And I should see "1/3/2010 08:13:23"
  
