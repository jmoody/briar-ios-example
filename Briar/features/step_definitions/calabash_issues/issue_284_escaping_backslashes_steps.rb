Then(/^a string with one backslash is typed$/) do
  actual = text_from_first_responder
  expected = 'A non-interpolated string \ with one backslash'
  unless expected == actual
    raise "Expected '#{expected}' to be typed but found '#{actual}'"
  end
end

Then(/^a string with several backslash is typed$/) do
  actual = text_from_first_responder
  expected = 'This non-interpolated \ string \ has \ several \ backslashes'
  unless expected == actual
    raise "Expected '#{expected}' to be typed but found '#{actual}'"
  end
end

Then(/^a string with a backslash at the beginning is typed$/) do
  actual = text_from_first_responder
  expected = '\A string that starts with a backslash'
  unless expected == actual
    raise "Expected '#{expected}' to be typed but found '#{actual}'"
  end
end

Then(/^a string with a backslash at the end is typed$/) do
  actual = text_from_first_responder
  expected = 'A string that ends with a backslash\\'
  unless expected == actual
    raise "Expected '#{expected}' to be typed but found '#{actual}'"
  end
end

When(/^I type an? (non-interpolated|interpolated) string with (one|two|several) (?:backslashes|backslash)$/) do |str_type, backslash_count|
  if str_type == 'interpolated'
    if backslash_count == 'one'
      string = "An interpolated string \ with one backslash"
    elsif backslash_count == 'two'
      string = "This interpolated string \ has two \ backslashes"
    else
      string = "This interpolated \ string \ has \ several \ backslashes"
    end
    keyboard_enter_text string
  else
    if backslash_count == 'one'
      @expected_string_with_backslash = 'A non-interpolated string \ with one backslash'
    elsif backslash_count == 'two'
      @expected_string_with_backslash = 'This non-interpolated string \ has two \ backslashes'
    else
      @expected_string_with_backslash = 'This non-interpolated \ string \ has \ several \ backslashes'
    end
    keyboard_enter_text @expected_string_with_backslash
  end
end

Then(/^I should see the backslash has been correctly (?:escaped|typed)$/) do
  @expected_string_with_backslash
  actual = text_from_first_responder
  unless @expected_string_with_backslash == actual
    raise "Expected '#{@expected_string_with_backslash}' to be typed but found '#{actual}'"
  end
end

When(/^I type a non-interpolated string that (starts|ends) with a backslash$/) do |backslash_position|
  case backslash_position
    when 'starts'
      string = '\A string that starts with a backslash'
    when 'ends'
      string = 'A string that ends with a backslash\\'
    else
      raise "Expected '#{backslash_position}' to be one of '#{['starts', 'ends']}'"
  end
  keyboard_enter_text string
  @expected_string_with_backslash = string
end


When(/^I type a non-interpolated string with a (double|triple) backslash$/) do |backslash_count|
  case backslash_count
    when 'double'
      string = 'A non-interpolated string with \\ double backslash'
    when 'triple'
      string = 'A non-interpolated string with \\\ triple backslash'
    else
      raise "Expected '#{backslash_count}' to be one of '#{['double', 'triple']}'"
  end
  keyboard_enter_text string
  @expected_string_with_backslash = string
end


Then(/^I should see that (\d+) backslash has been typed$/) do |expected_backslash_count|
  text = text_from_first_responder
  actual_count = text.scan(/\\/).count
  expected_count = expected_backslash_count.to_i
  unless actual_count == expected_count
    raise "Expected '#{text}' to have #{expected_count} backslashes but found #{actual_count}"
  end
end


When(/^I type an interpolated string with a (double|triple|quadruple) backslash$/) do |backslash_count|
  if backslash_count == 'double'
    string = "An interpolated string with \\ double backslash"
  elsif backslash_count == 'triple'
    string = "An interpolated string with \\\ triple backslash"
  else
    string = "An interpolated string with \\\\ quadruple backslash"
  end
  keyboard_enter_text string
  @expected_string_with_backslash = string
end

Then(/^I see that the single backslash was escaped to a dot$/) do
  actual = text_from_first_responder
  expected = 'An interpolated string. with one backslash'
  unless expected == actual
    raise "Expected '#{expected}' to be typed but found '#{actual}'"
  end
end
