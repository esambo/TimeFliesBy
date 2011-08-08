Feature: Task: Error: Time Gap
  >I order to see where I spend my time  
  As a person reflecting on my time  
  I want to have a continuous timeline without gaps or overlaps  

  Background: Signed in
    Given I am signed in as a new user
  
  @time_travel
  Scenario: Fill time gap
    Given it is "1/3/2010 8:13:23 AM"
    And I have a task "Oldest" that started "10m" ago
    And I have a task "Old" that started "6m" ago
    And I have a task "With STOP!" that started "3m" and stopped "1m" ago
    When I have a task "New" that started "0s" ago
    And I am on the tasks page
    Then I should see "Error: Time gap!" title in task 2
  
