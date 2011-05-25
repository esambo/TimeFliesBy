Feature: Tag
  >In order to categorize where I spend my time  
  As a person short on time  
  I want to tag my tasks  
  
  Background: Signed in
    Given I am signed in as a new user
  
  Scenario: Create tag
    Given I am on the new tag page
    And I fill in "Education" for "tag_name"
    When I press "Create Tag"
    Then I should see "Tag was successfully created."
    And I should see "Education"
  
  Scenario: Add tags to new task
    Given I have the tags "Education, Read Book, BDD"
    And I am on the new task page
    And I check "Education"
    And I check "Read Book"
    When I press "Create Task"
    Then I should see "Education"
    And I should see "Read Book"
  
