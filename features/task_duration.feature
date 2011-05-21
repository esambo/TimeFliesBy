Feature: Task Duration
  >In order to get a feeling of what I am doing  
  As a daily end user  
  I want to see the duration of my current task  

  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: 1 minute duration
    Given I have a "1m" task
    When I am on the tasks page
    Then I should see "1m"
  