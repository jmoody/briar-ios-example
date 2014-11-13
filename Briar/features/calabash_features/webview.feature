Feature: Interacting with a WebView

  @wip
  Scenario: Following a link in a webview
    Given I am looking at the web view page
    Then I should see "You're at the top"
    When I press "bottom"
    Then I should see "You've hit Rock Bottom"
