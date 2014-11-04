Feature: Interacting with a WebView

  Scenario: Following a link in a webview
    Given I'm looking at a webview of Google
    And I search for "miserable failure"
    And I press "search"
    Then I should see "George W. Bush"
