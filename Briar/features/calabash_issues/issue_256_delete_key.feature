@keyboard
@numeric_keyboard
@issue_256
@delete_key
Feature: keyboard delete
  In order to test keyboard interaction
  As a calabash-ios gem tester
  I want to be able to touch the delete key on all keyboards

  Background: get me to the text related view
    Given I am looking at the Text tab

  Scenario: exercise the default keyboard
    And one of the input views has the default keyboard showing
    Then I type "mary had a little limb"
    And realize my mistake and delete 3 characters and replace with "amb"

  @ascii
  Scenario: exercise the ascii keyboard
    And the one of the input views has an ascii keyboard showing
    Then I text my friend a facepalm "(>_>]"
    And realize my mistake and delete 1 character and replace with ")"

  Scenario: exercise the numbers and punctuation keyboard
    And one of the input views has the numbers and punctuation keyboard showing
    Then I say, "yeah"
    Then he said, "hear what I say sir"
    And he said, "you do what I say sir"
    And he said, "put your hand on your head sir"
    And you will get no hurt now
    Then I say, "yeah"
    Then he said, "what's your number?"
    Then I say, "54-36" that's my number
    And realize my mistake and delete 2 characters and replace with "46"

  @url
  Scenario: exercise the url keyboard
    And one of the input views has the url keyboard showing
    Then I try to visit "http://amazon.com.uk"
    And realize my mistake and delete 4 characters and replace with ".uk"

  @number_pad
  Scenario: exercise the number pad
    And one of the input views has the number pad showing
    Then I change my pin to "0123"
    And realize my mistake and delete 3 characters and replace with "034"

  @phone_number
  Scenario: exercise the phone pad
    And one of the input views has the phone pad showing
    Then dial "8675409"
    And realize my mistake and delete 3 characters and replace with "309"

  @phone_number
  Scenario: exercise the phone pad with an international number
    And one of the input views has the phone pad showing
    Then dial "+86898888888*"
    And realize my mistake and delete 1 characters and replace with "8"

  # broken - does not work on
  #  * iOS 6 iPhone 4S w/o instruments
  #  * iOS 6 iPhone Sim
  # so it is not really flickering but i need to mark it somehow
  @flickering
  @phone_number
  @name_and_phone
  Scenario: exercise the name and phone keyboard
    And one of the input views has the name and phone keyboard showing
    Then try to call "GHOST BUSTERS" at "5556162"
    And realize my mistake and delete 4 characters and replace with "2368"

  @email
  Scenario: exercise the email keyboard
    And one of the input views has the email keyboard showing
    Then I start to send an email to "foobart@example.com"
    And realize my mistake and delete 13 characters and replace with "@example.com"

  # flickering because in the rest of the world, they use a ',' instead of a '.'
  # for decimals
  @decimal
  Scenario: exercise the decimal keyboard
    And one of the input views has the decimal keyboard showing
    Then I type pi as "3.16"
    And realize my mistake and delete 1 character and replace with "4"

  @decimal
  Scenario: exercise the decimal keyboard
    And one of the input views has the decimal keyboard showing
    Then I type "1113213212"
    And realize my mistake and delete 1 character and replace with "1"

  @twitter
  Scenario: exercise the twitter keyboard
    And one of the input views has the twitter keyboard showing
    Then I tweet "rocking robin, tweet tweet" and tag with with "#thweet"
    And realize my mistake and delete 5 characters and replace with "weet"

  @web_search
  Scenario: exercise the twitter keyboard
    And one of the input views has the web search keyboard showing
    #noinspection SpellCheckingInspection
    Then search for "Repot Man"
    And realize my mistake and delete 5 characters and replace with " Man"
