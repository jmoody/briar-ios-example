require 'calabash-cucumber/cucumber'
ENV['NO_BRIAR_PREDEFINED_STEPS'] = '1'
require 'briar/cucumber'
require 'faker'
require 'pry'

I18n.enforce_available_locales = false
