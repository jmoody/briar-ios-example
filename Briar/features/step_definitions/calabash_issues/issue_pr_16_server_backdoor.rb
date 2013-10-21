module Briar
  module Email
    def device_configured_for_email
      # this is a recognized selector
      configured_for_mail_sel = 'calabash_backdoor_configured_for_mail:'
      res = backdoor(configured_for_mail_sel, 'ignorable')
      valid_responses = %w(YES NO)
      unless valid_responses.include?(res)
        screenshot_and_raise "backdoor '#{configured_for_mail_sel}' should return '#{valid_responses}' but returned '#{res}'"
      end
      res.eql?('YES')
    end
  end
end

World(Briar::Email)

Then /^I ask the application if the device is configured to send email$/ do
  device_configured_for_email
end

Then /^I ask the application if the device is configured scan for lifeforms$/ do
  scanning_lifeforms_sel = 'scan_for_lifeforms:'
  # expected to fail
  begin
    backdoor(scanning_lifeforms_sel, 'ignorable')
    pending('should see an error here')
  rescue
    puts "successfully threw an error and did not crash the app when passing an unrecognized selector to 'backdoor'"
  end
end
