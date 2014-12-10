@scrolling
@webview
Feature: Interacting with a WebView
  In order to ensure calabash can interact with a WebView
  As a tester
  I want to test the basic functionality of a WebView

  Scenario: Following a link in a webview
    Given I am looking at the web view page
    When I touch a link to reveal a message
    Then I should see the message is revealed
