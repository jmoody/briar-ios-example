When(/^I call the a deprecated function I should see a warning with a stack trace$/) do
  _deprecated('0.9.163', 'this has been deprecated', :warn)
end

When(/^I call a deprecated step I should see a pending exception$/) do
  begin
    _deprecated('0.9.163', 'this has been deprecated', :pending)
  rescue
    puts 'INFO:  step failed correctly' if full_console_logging?
  end
end