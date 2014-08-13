@page
@scrolling
Feature: scrolling views menu
  In order to test a variety of UIScrollView subclasses
  As a tester
  I want a scrolling views menu

  Background: get me to the scrolling home view
    Given I see the views that scroll home view

  Scenario: I want to see the alphabet table
    And I go to the alphabet table
    Then I can go back to the scrolling home view

  Scenario: I want to see the collection view
    And I go to the collection view page
    Then I can go back to the scrolling home view
