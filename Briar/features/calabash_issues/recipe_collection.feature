@collection_view
Feature: interacting with collection views
  In order to silence the quell the clambering horde
  As a tester
  I want calabash function to interact with collection views

  Background: I want to see the collection view
    Given I see the views that scroll home view
    And I go to the collection view page

  Scenario: then i want to scroll around
    Then I look for the picture of the "hamburger"
    Then I look for the picture of the "risotto"
    Then I look for the picture of the "cake"
    