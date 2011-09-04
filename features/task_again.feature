Feature: Switch To Task Again
  >In order to make time tracking quick and easy  
  As a person short on time  
  I want to switch back to an existing task again  

  Background: Signed in
    Given I am signed in as a new user
  
  @time_travel
  Scenario: Switch back to the oldest task again (on the task listing)
    Given it is "1/3/2010 8:13:23 AM"
    And I have a task "Read emails" that started "10m" ago
    And I have a task "Something else" that started "5m" ago
    And I am on the tasks page
    When I press "Again" in the oldest task
    Then I should see "Task was successfully switched back to again."
    And I should see "8:13:23 AM" start in task 1
    And I should see "Read emails" title in task 1
  
