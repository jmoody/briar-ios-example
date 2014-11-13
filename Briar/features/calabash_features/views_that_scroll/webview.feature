@scrolling
Feature: Interacting with a WebView
  In order to ensure calabash can interact with a WebView
  As A tester
  I want to test the basic functionality of a WebView

  Scenario: Following a link in a webview
    Given I am looking at the web view page
    When I touch a link to the bottom of the page
    Then I should be at the bottom of the page
