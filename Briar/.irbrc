require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

ARGV.concat [ "--readline",
              "--prompt-mode",
              "simple" ]

# 25 entries in the list
IRB.conf[:SAVE_HISTORY] = 50

# Store results in home directory with specified file name
IRB.conf[:HISTORY_FILE] = ".irb-history"

require 'calabash-cucumber/operations'
require 'calabash-cucumber/launch/simulator_helper'

SIM=Calabash::Cucumber::SimulatorHelper
include Calabash::Cucumber::Operations

require 'briar'

include Briar::Bars
include Briar::Alerts_and_Sheets
include Briar::Control::Button
include Briar::Control::Segmented_Control
include Briar::Control::Slider
include Briar::Picker
include Briar::Picker::Date
include Briar::Picker_Shared
include Briar::Core

def embed(x,y=nil,z=nil)
   puts "Screenshot at #{x}"
end

def access_ids
  @ai = :accessibilityIdentifier 
  query("view", @ai).compact.sort.each {|x| puts "* #{x}" }
end

def navbar_button_labels
    query("navigationButton", :accessibilityLabel)
end
