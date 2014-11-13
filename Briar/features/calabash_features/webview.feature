Feature: Interacting with a WebView

  @wip
  Scenario: Following a link in a webview
    Given I am looking at the web view page
    When I touch a link to the bottom of the page
    Then I should be at the bottom of the page
