
Then(/^I should be able to set the text in the top text field to "([^"]*)"$/) do |arg|
  set_text("textField marked:'top tf'", arg)
end

Then(/^I should get an exception using set_text on a text field that does not exist$/) do
  begin
    set_text("textField marked:'bad mark'", 'hey!')
    error_no_rescue 'expected set_text to fail because it could not find the marked view'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end

And(/^I type "([^"]*)" into the (top|bottom) text (field|view)$/) do |arg, loc, clz|
  qstr = "text#{clz.capitalize} marked:'#{loc} #{clz == 'field' ? 'tf' : 'tv'}'"
  touch(qstr)
  wait_for_keyboard
  ensure_text_input(arg, 'typing')
end

Then(/^I should be able to clear the (top|bottom) text (field|view) with clear_text$/) do |loc,clz|
  qstr = "text#{clz.capitalize} marked:'#{loc} #{clz == 'field' ? 'tf' : 'tv'}'"
  clear_text(qstr)
  res = query(qstr, :text).first
  unless res == ''
    screenshot_and_raise "expected top text field to have '' but found '#{res}'"
  end
end

Then(/^I should get an exception using clear_text on a text (field|view) that does not exist$/) do |clz|
  begin
    clear_text("text#{clz.capitalize} marked:'bad mark'", 'hey !')
    error_no_rescue 'expected clear_text to fail because it could not find the marked view'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end

Then(/^I should get an exception using clear_text on a view that does not respond to setText$/) do
  begin
    clear_text("button marked:'save to keychain'")
    error_no_rescue "expected clear_text to fail because query found a view that did not respond to 'setText'"
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end

And(/^I am looking at the date and time picker$/) do
  touch_button_and_wait_for_view('show date and time picker','date and time picker')
end

Then(/^I call picker_set_date_time when there is no date picker visible$/) do
  begin
    picker_set_date_time(DateTime.now)
    error_no_rescue 'expected picker_set_date_time to fail because query found no date picker'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end


Then(/^I call picker_set_date_time with a non-DateTime object$/) do
  begin
    picker_set_date_time(Time.now)
    error_no_rescue 'expected picker_set_date_time to fail because it was passed a non-DateTime object'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end

Then(/^I call scroll down on the table$/) do
  table_mark = 'table'
  scroll("view marked:'#{table_mark}'", :down)
  step_pause
end

Then(/^I call scroll on a non-existent view$/) do
  begin
    scroll("view marked:'no mark!'", :down)
    error_no_rescue 'expected scroll to fail because query found on view to scroll on'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end


Then(/^I call scroll on a view that is not a scroll view$/) do
  begin
    scroll("view marked:'buttons'", :down)
    error_no_rescue 'expected scroll to fail because the query returned an non-scroll view'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end

Then(/^I call scroll_to_row 10$/) do
  scroll_to_row("view marked:'table'", 10)
  step_pause
end

Then(/^I call scroll_to_row on a non-existent view$/) do
  begin
    scroll_to_row("view marked:'buttons'", 1)
    error_no_rescue 'expected scroll_to_row to fail because the query returned an non-table view'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end

Then(/^I call scroll_to_row_with_mark on a non-existent view$/) do
  begin
    scroll_to_row_with_mark('m')
    error_no_rescue 'expected scroll_to_row_with_mark to fail because the query returned an non-table view'
  rescue
    puts 'correctly threw exception' if full_console_logging?
  end
end

Then(/^I call scroll_to_row_with_mark on the "([^"]*)" row$/) do |arg|
  scroll_to_row_with_mark arg
  step_pause
end