@briar
@core
Feature: test the core features of briar

  Background: to test the core features the buttons view should be visible
    When I touch the "Buttons" tab I should see the "buttons" view

  Scenario:  i should be able to use briar to test for view visibility
    Then I should see the "show email" view
    Then I should not see the "foobar" view
    Then I should see the text related views after touching the Text tab



