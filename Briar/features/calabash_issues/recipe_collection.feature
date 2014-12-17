@collection_view
Feature: Interacting with collection views
  In order to silence the clambering horde
  As a tester
  I want calabash function to interact with collection views

  Background: I want to see the collection view
    Given I see the views that scroll home view
    And I go to the collection view page

  Scenario: then i want to scroll around using sections and items
    Then I look for the picture of the "hamburger"
    Then I look for the picture of the "risotto"
    Then I look for the picture of the "cake"
    Then I can go back to the scrolling home view


  Scenario: then i want to scroll around using marks
    Then I scroll to the recipe with access id "thai shrimp cake"
    Then I scroll to the recipe with access id "mushroom risotto"
    Then I scroll to the recipe with access label "Angry birds cake"
    Then I can go back to the scrolling home view
