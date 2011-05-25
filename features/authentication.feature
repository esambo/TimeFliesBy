Feature: Authentication
  >In order to prevent people from seeing each others data 
  As a software as a service provider  
  I want to identify each user  

  Scenario: Authentication required
    Given I am on the home page
    When I follow "Tasks"
    Then I should see "You need to sign in or register before continuing."
  
  Scenario: Register as new user
    Given I am on the home page
    And I follow "Register"
    And I fill in "user_email" with "test@timefliesby.com"
    And I fill in "user_password" with "secret"
    And I fill in "user_password_confirmation" with "secret"
    When I press "Register"
    Then I should be on the home page
    And I should see "Welcome! You have registered successfully."
  
  Scenario: Verify email
    Given I registered as a new user
    When I follow "Confirm my account" in the "Confirmation instructions" email
    Then I should be on the home page
    And I should see "Your account was successfully confirmed. You are now signed in."
  
  Scenario: Sign in
    Given I am a registered user
    And I am on the home page
    And I follow "Sign in"
    And I fill in "user_email" with "test@timefliesby.com"
    And I fill in "user_password" with "secret"
    When I press "Sign in"
    Then I should see "Signed in successfully."
    And I should see "Sign out"
  
  Scenario: Sign out
    Given I am signed in as a new user
    When I follow "Sign out"
    Then I should be on the home page
    And I should see "Signed out successfully."
  
