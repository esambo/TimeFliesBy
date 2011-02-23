Feature: Authentication
  In order to allow multiple people from using the application independently
  As a any kind of user
  I want to have my data stored by my user ID

  Scenario: Authentication required
    Given I am on the home page
    Then I should see "Sign in"
    And I should not see "Sign out"
#    When I follow "Tasks"
#    Then I should see "You need to sign in or register before continuing."

  Scenario: Register as new user
    Given I am on the home page
    And I follow "Register"
    And I fill in "user_email" with "test@timefliesby.com"
    And I fill in "user_password" with "secret"
    And I fill in "user_password_confirmation" with "secret"
    When I press "Register"
    Then I should be on the home page
    And I should see "You have registered successfully. A confirmation was sent to your e-mail."

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

  Scenario: Sign out
    Given I am signed in as a new user
    And I am on the tasks page
    When I follow "Sign out"
    Then I should be on the home page
    And I should see "Signed out successfully."