Then(/^I should not see the tab bar if I am on the iphone or if ipad is orientated left or right$/) do
  stats = orientation_stats
  device_o = stats[:device]
  if ipad? && (device_o.eql?('left') || device_o.eql?('right'))
    should_see_tabbar
  else
    should_not_see_tabbar
  end
end

Then(/^I wait for rotation animation$/) do
  3.times { step_pause }
end

Given(/^that I (have not|have) launched the app$/) do |arg|
  if arg.eql?('have not')
    unless ENV['NO_LAUNCH'] == '1'
      screenshot_and_raise "expected ENV['NO_LAUNCH'] to != '1' but found '#{ENV['NO_LAUNCH']}'"
    end
  else
    unless ENV['NO_LAUNCH'] == '0'
      screenshot_and_raise "expected ENV['NO_LAUNCH'] to != '0' but found '#{ENV['NO_LAUNCH']}'"
    end
  end
end

Then(/^I am waiting for a fix for the :preferences strategy$/) do
  uia_strategy = Calabash::Cucumber::Launcher.launcher.run_loop[:uia_strategy]
  if uia_strategy == :preferences
    pending 'Waiting for a fix for gestures on when using :preferences strategy'
  end
end
