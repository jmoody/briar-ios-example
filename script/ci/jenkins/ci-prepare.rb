#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))

### prepare

# can safely skip
# update_rubygems
uninstall_gem 'briar'
uninstall_gem 'calabash-cucumber'
uninstall_gem 'run_loop'
uninstall_gem 'xamarin-test-cloud'

working_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'Briar'))

Dir.chdir working_dir do

  do_system('rm -rf Gemfile.lock')
  do_system('rm -rf .bundle')
  do_system('rm -rf vendor')
  do_system('cp .env-jenkins .env')

end