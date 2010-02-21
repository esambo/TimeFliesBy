Feature: Task stop greater than start or blank
  In order to avoid mistakes
  As a troubleshooting user
  I want to ensure that stop is greater than start

  Background: Signed in
    Given I am signed in as a new user

  Scenario: Validation error for stop before start
    Given I am on the new task page
    When I fill in "start" with "1/21/2010 8:38 PM"
    When I fill in "stop" with "1/21/2010 8:30 PM"
    And I press "Create"
    Then I should see "Stop needs to be greater than start."

