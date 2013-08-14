require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
require 'awesome_print'
AwesomePrint.irb!

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

extend Calabash::Cucumber::Operations

def embed(x,y=nil,z=nil)
   puts "Screenshot at #{x}"
end


#### begin briar ####

require 'briar'

include Briar::Bars
include Briar::Alerts_and_Sheets
include Briar::Control::Button
include Briar::Control::Segmented_Control
include Briar::Control::Slider
include Briar::Picker
include Briar::Picker_Shared
include Briar::Picker::DateCore
include Briar::Picker::DateManipulation
include Briar::Picker::DateSteps
include Briar::Core
include Briar::Table
include Briar::ImageView


@ai=:accessibilityIdentifier
@al=:accessibilityLabel
def access_ids
  query("view", @ai).compact.sort.each {|x| puts "* #{x}" }
end

def access_labels
  query("view", @al).compact.sort.each {|x| puts "* #{x}" }
end

def navbar_button_labels
    query("navigationButton", :accessibilityLabel)
end

puts "loaded local .irbrc"
