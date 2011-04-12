Feature: Task Switch
  In order to quickly create a new task
  As a time tracker
  I want the current task to stop when switching to a new one

  Background: Signed in
    Given I am signed in as a new user
  
  @time_travel
  Scenario: New task using 'Switch'
    Given it is "1/3/2010 8:13:23 AM"
    And I am on the new task page
    When I press "Switch"
    Then I should see "Task was successfully created."
    And I should see "1/3/2010 08:13:23"
    And I should see "0s"
  
  @time_travel
  Scenario: Prevent time gaps
    Given it is "1/3/2010 8:13:23 AM"
    And I have a stop "1m" ago
    And I am on the new task page
    When I press "Switch"
    And it is "1/3/2010 8:13:24 AM"
    And I follow "Back"
    And I should see "Error: Time gap!"
    And I should see "1m"
  
  @time_travel
  Scenario: Duration on new task using 'Switch'
    Given it is "1/3/2010 8:13:23 AM"
    And I have a "1m" task
    And I am on the new task page
    When I press "Switch"
    Then I should see "Task was successfully created."
    And I should see "1/3/2010 08:13:23"
    And it is "1/3/2010 8:13:24 AM"
    And I reload the page
    And I should see "1s"
  
  @time_travel
  Scenario: Duration on current task
    Given it is "1/3/2010 8:13:23 AM"
    And I am on the new task page
    When I press "Switch"
    Then I should see "Task was successfully created."
    And I should see "1/3/2010 08:13:23"
    And I should see "0s"
  
  @time_travel
  Scenario: Duration on previous task
    Given it is "1/3/2010 8:13:23 AM"
    And I have a "1m" task
    And I am on the new task page
    When I press "Switch"
    And I follow "Back"
    Then I should see "1m" within ".duration"
  