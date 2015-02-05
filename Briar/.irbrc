require 'faker'
require 'briar'
require 'briar/irbrc'
require 'pry'
require 'pry-nav'

puts 'loaded briar'


helpers = [
      'briar_keyboard_helpers'
]

helpers.each do |helper|
  #noinspection RubyResolve
  require_relative "features/helpers/#{helper}"
end

pages = [

]

pages.each do |page|
  #noinspection RubyResolve
  require_relative  "features/pages/#{page}"
end



modules = [

]

modules.each do |mod|
  #noinspection RubyResolve
  require_relative "features/step_definitions/#{mod}"
end


puts_calabash_environment
briar_message_of_the_day
