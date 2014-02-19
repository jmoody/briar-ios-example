@issue_319
Feature: iphone_4in? API change
  In order to rest my weary bones
  As a calabash-ios gem developer
  I want iphone_4in? to replace iphone_5?

  Scenario: iphone_4in? should report correctly
    Given that that the iphone_5 function has been deprecated
    Then I expect that iphone_4in function should work correctly on all devices