#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))
require File.expand_path(File.join(File.dirname(__FILE__), 'run-masters'))

xtc_device_set = ARGV[0] || '50407ee5'
xtc_profile = ARGV[1] || 'default'


run_masters xtc_device_set, xtc_profile, 'nightly-masters'

working_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'Briar'))

Dir.chdir working_dir do

  # sometimes json 1.8.1 cannot be found
  install_gem 'json'

  do_system('./jenkins-calabash.sh')
end
