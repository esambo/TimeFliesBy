Feature: Task Duration
  >In order to see where I spend a lot of time  
  As a person short on time  
  I want to see the duration of each task  

  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: 1 minute duration
    Given I have a "1m" task
    When I am on the tasks page
    Then I should see "1m"
  
