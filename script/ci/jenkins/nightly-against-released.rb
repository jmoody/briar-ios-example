#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))

xtc_device_set = ARGV[0] || '2d0063dc'
xtc_profile = ARGV[1] || 'default'

### prepare

do_system(File.expand_path(File.join(File.dirname(__FILE__), 'ci-prepare.rb')))

working_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'Briar'))

Dir.chdir working_dir do

  do_system('rm -rf calabash.framework')
  do_system('bundle install')
  do_system('bundle exec calabash-ios download')

  File.open('.env', 'a') { |f| f.write("XTC_SERIES=\"nightly-released\"") }

  do_system("bundle exec briar xtc #{xtc_device_set} #{xtc_profile}")

  # sometimes json 1.8.1 cannot be found
  install_gem 'json'

  do_system('./jenkins-calabash.sh')

end
