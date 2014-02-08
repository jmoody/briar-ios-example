@trello
@trello_631

Feature: expecting map results
  In order to reduce duplicate code
  As a calabash developer
  I want a nice way to assert that +map+ returns valid results

  @text
  @deprecated_function
  Scenario: expecting set_text to pass
    Given I am looking at the Text tab
    Then I should be able to set the text in the top text field to "foobar"

  @allow-rescue
  @text
  @deprecated_function
  Scenario: expecting set_text to fail
    Then I should get an exception using set_text on a text field that does not exist

  @text
  @keyboard
  Scenario: expecting clear_text to pass on text fields
    Given I am looking at the Text tab
    And all the text input view have the default keyboard
    And I type "foobar" into the top text field
    Then I should be able to clear the top text field with clear_text

  @allow-rescue
  @text
  @keyboard
  Scenario: expecting clear_text to fail on text fields
    Then I should get an exception using clear_text on a text field that does not exist

  @text
  @keyboard
  Scenario: expecting clear_text to pass on text views
    Given I am looking at the Text tab
    And all the text input view have the default keyboard
    And I type "foobar" into the top text view
    Then I should be able to clear the top text view with clear_text

  @allow-rescue
  @text
  @keyboard
  Scenario: expecting clear_text to fail on a text view
    Then I should get an exception using clear_text on a text view that does not exist

  @allow-rescue
  @text
  @keyboard
  Scenario: expecting clear_text to fail because the view does not respond to setText
    Given I am looking at the Text tab
    Then I should get an exception using clear_text on a view that does not respond to setText

  @date_picker
  Scenario:  expecting to be able to use picker_set_date_time
    Given that I am looking at the Date tab
    And I am looking at the date and time picker
    Then I change the date picker date to "Sep 14 2013" at "13:15"

  @allow-rescue
  @date_picker
  Scenario:  expecting that picker_set_date_time will raise an error if no view is found
    Then I call picker_set_date_time when there is no date picker visible

  @allow-rescue
  @date_picker
  Scenario:  expecting that picker_set_date_time will raise an error if called with a non-DateTime object
    Then I call picker_set_date_time with a non-DateTime object

  @table
  @scroll
  Scenario: expecting scroll to pass
    Given I am looking at the Alphabet table
    Then I call scroll down on the table

  @allow-rescue
  @scroll
  Scenario: expecting scroll to fail because it cannot find a view
    Then I call scroll on a non-existent view

  # smoke tested on Rise Up because Briar does not have any UIWebViews
  #todo make a test for scroll fail on non webView
  @allow-rescue
  @scroll
  Scenario: expecting scroll to fail because the view is not a scrollView
    Then I call scroll on a view that is not a scroll view

  # scroll_to_row and scroll_to_cell call the same map function: scrollToRow
  # so there is no need to test scroll_to_cell in this context
  @scroll
  @table
  Scenario: expecting scroll_to_row to pass
    Given I am looking at the Alphabet table
    Then I call scroll_to_row 10

  @scroll
  @table
  @allow-rescue
  Scenario: expecting scroll_to_row to fail because the query returned a non-table view
    Then I call scroll_to_row on a non-existent view

  @scroll
  @table
  Scenario: expecting scroll_to_row_with_mark to pass
    Given I am looking at the Alphabet table
    Then I call scroll_to_row_with_mark on the "j" row

  @scroll
  @table
  @allow-rescue
  Scenario: expecting scroll_to_row_with_mark to fail because the query returned a non-table view
    Then I call scroll_to_row_with_mark on a non-existent view


