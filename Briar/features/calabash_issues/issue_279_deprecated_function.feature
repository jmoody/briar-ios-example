@deprecated
@smoke_test
Feature: the calabash deprecated function
  In order to allow steps, functions, and methods to be deprecated
  As a calabash gem developer
  I want deprecated function

  Scenario:  the _deprecated function generates a warning with a stack trace
    When I call the a deprecated function I should see a warning with a stack trace

  @allow-rescue
  Scenario:  the _deprecated function generates a pending exception
    When I call a deprecated step I should see a pending exception