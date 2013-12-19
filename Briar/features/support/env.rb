require 'calabash-cucumber/cucumber'
require 'briar/cucumber'
require 'faker'

I18n.enforce_available_locales = false

#http://stackoverflow.com/questions/9582926/launching-retina-simulator-from-xcodebuild-for-continuous-integration
#target_simulator = "iPad"
#current_simulator = `defaults read com.apple.iphonesimulator "SimulateDevice"`.chomp
#
#if current_simulator != target_simulator
#  `killall 'iPhone Simulator'`
#  `defaults write com.apple.iphonesimulator "SimulateDevice" '"#{target_simulator}"'`
#end

#def set_simulated_device(simulated_device)
#  current_simulated_device = `defaults read com.apple.iphonesimulator "SimulateDevice"`.chomp
#
#  if current_simulated_device != simulated_device
#    simulator_pid = `ps -ax|awk '/[i]Phone Simulator.app\\/Contents\\/MacOS\\/iPhone Simulator/{print $1}'`.chomp
#    Process.kill('INT', simulator_pid.to_i) unless simulator_pid.empty?
#    `defaults write com.apple.iphonesimulator "SimulateDevice" '"#{simulated_device}"'`
#  end
#end

#"iPhone Retina (3.5-inch)"
#"iPhone Retina (4-inch)"
#"iPhone Retina (4-inch 64-bit)"
#"iPad"
#"iPad Retina"
#"iPad Retina (64-bit)"