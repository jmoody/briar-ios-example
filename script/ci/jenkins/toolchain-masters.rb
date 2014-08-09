#!/usr/bin/env ruby

# runs xtc job + local simulator tests
# see Briar/jenkins-calabash.sh

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))
require File.expand_path(File.join(File.dirname(__FILE__), 'run-masters'))

xtc_device_set = ARGV[0] || 'toolchain-masters'
xtc_profile = ARGV[1] || 'default'

run_masters xtc_device_set, xtc_profile, 'toolchain-masters'

working_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'Briar'))

Dir.chdir working_dir do

  # sometimes json 1.8.1 cannot be found
  install_gem 'json'

  do_system('./jenkins-calabash.sh')
end