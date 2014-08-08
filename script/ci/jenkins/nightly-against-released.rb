#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))

xtc_device_set = ARGV[0] || 'jenkins-ci'
xtc_profile = ARGV[1] || 'default'

### prepare

update_rubygems
uninstall_gem 'briar'
uninstall_gem 'calabash-cucumber'
uninstall_gem 'run_loop'
uninstall_gem 'xamarin-test-cloud'

working_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'Briar'))

Dir.chdir working_dir do

  # maybe wrap this up?
  do_system('rm -rf Gemfile.lock')
  do_system('rm -rf .bundle')
  do_system('rm -rf vendor')
  do_system('bundle install')

  do_system('rm -rf calabash.framework')
  do_system('bundle exec calabash-ios download')

  do_system('cp .env-jenkins .env')
  do_system("bundle exec briar xtc #{xtc_device_set} #{xtc_profile}")

end