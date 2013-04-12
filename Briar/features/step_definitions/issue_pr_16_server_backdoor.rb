Then /^I ask the application if the device is configured to send email$/ do
  # this is a recognized selector
  configured_for_mail_sel = 'calabash_backdoor_configured_for_mail:'
  res = backdoor(configured_for_mail_sel, 'ignorable')
  valid_responses = %w(YES NO)
  unless valid_responses.include?(res)
    screenshot_and_raise "backdoor '#{configured_for_mail_sel}' should return '#{valid_responses}' but returned '#{res}'"
  end
end

Then /^I ask the application if the device is configured scan for lifeforms$/ do
  # pending: https://github.com/calabash/calabash-ios-server/pull/16
  # otherwise this will crash the app
  # this is not a recognized selector
  scanning_lifeforms_sel = 'scan_for_lifeforms:'
  # expected to fail
  backdoor(scanning_lifeforms_sel, 'ignorable')
end
