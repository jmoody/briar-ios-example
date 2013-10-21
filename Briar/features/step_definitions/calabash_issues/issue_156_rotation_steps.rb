module Briar
  module Issue_156
    def orientation_stats
      d = device_orientation
      sb = status_bar_orientation
      { :device => d,
        :status_bar => sb,
        :eql => d.eql?(sb)}
    end

    def should_have_eql_orientations
      stats = orientation_stats
      unless stats[:eql]
        screenshot_and_raise "expected device orientation '#{stats[:device]}' to be the same as status bar orientation '#{stats[:status_bar]}'"
      end
    end

    def rotate_so_home_is_on (home_position)
      home_position = 'down' if home_position.eql?('bottom')
      home_position = 'up' if home_position.eql?('top')
      rotate_home_button_to home_position
      step_pause
    end
  end
end

World(Briar::Issue_156)


When(/^I rotate the device (left|right), I should see the status bar and device have the same orientation$/) do |dir|
  rotate(dir.to_sym)
  step_pause
  should_have_eql_orientations
end

Then(/^I rotate the device (\d+) times in a random direction$/) do |n|
  n.to_i.times {
    rotate ([:left, :right].sample)
    2.times { step_pause }
  }
end

Then(/^the (status bar|device) orientation should be "([^"]*)"$/) do |bar_or_device, orientation|
  stats = orientation_stats
  key = bar_or_device.eql?('device') ? :device : :status_bar
  unless orientation.eql?(stats[key])
    screenshot_and_raise "#{bar_or_device} orientation should be '#{orientation}' but found '#{stats[key]}'"
  end
end

Then(/^the device orientation should be "([^"]*)" on the simulator and "([^"]*)" on device$/) do |sim_o, device_o|
  stats = orientation_stats

  actual_device_o = stats[:device]
  if actual_device_o.eql?('face up') or actual_device_o.eql?('face down')
    pending "testing against orientation '#{actual_device_o}' is not supported for this test - move your device to an upright position"
  end

  is_sim = device.simulator?
  expect = is_sim ? sim_o : device_o
  platform = is_sim ? 'simulator' : 'device'
  unless expect.eql?(stats[:device])
    screenshot_and_raise "device orientation on '#{platform}' should be '#{expect}' but found '#{stats[:device]}'"
  end
end

Then(/^the orientation of the status bar and device should be same$/) do
  should_have_eql_orientations
end

Then(/^I rotate the device so the home button is on the (right|left|bottom|top)$/) do |home_position|
  rotate_so_home_is_on home_position
end

Then(/^I rotate the home button to the (.*) position$/) do |position|
  rotate_so_home_is_on position
end

Given(/^the device is in the portrait orientation$/) do
  rotate_so_home_is_on 'bottom'
end

