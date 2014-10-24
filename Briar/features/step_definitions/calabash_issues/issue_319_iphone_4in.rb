Given(/^that that the iphone_5 function has been deprecated$/) do
  iphone_5?
end


Then(/^I expect that iphone_4in function should work correctly on all devices$/) do
  # the issue is that iPhone 5S is reporting iPhone6,1
  if ipad?
    if iphone_4in?
      raise 'expected iphone_4in? to always be false for ipads'
    end
  elsif device_family_iphone?

    device = _default_device_or_create()
    if simulator?
      pending('Need to replace this with a good test; simulator_details are no longer available in Xcode 6')
      # if device.simulator_details.scan('4-inch').empty? == iphone_4in?
      #   raise "expected iphone_4in? to match simulator details #{device.simulator_details}"
      # end
    else
      major_hardware_version = device.system.split(/[\D]/).delete_if { |x| x.eql?('') }.first
      if ['5', '6'].include?(major_hardware_version)
        unless iphone_4in?
          raise "expected iphone_4in? to be 'true' for device with major version '#{major_hardware_version}'"
        end
      else
        if iphone_4in?
          raise "expected iphone_4in? to be 'false' for device with major version '#{major_hardware_version}'"
        end
      end
    end
  else
    raise 'expected either an iphone, ipod, or ipad'
  end

end
