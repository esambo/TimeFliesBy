Feature: Task for each User
  >In order to support multiple people tracking their time 
  As a software as a service provider  
  I want them to have their own independent data  

  Scenario: Users should not see each others tasks
    Given I am signed in as a new user "test1@timefliesby.com"
    And I have a task "Task 1 from user: test1"
    And I am on the tasks page
    And I should see "Task 1 from user: test1"
    When I follow "Sign out"
    And I am signed in as a new user "test22@timefliesby.com"
    And I am on the tasks page
    Then I should not see "Task 1 from user: test1"
  
