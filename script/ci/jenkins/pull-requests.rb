#!/usr/bin/env ruby

# runs xtc job + local simulator tests
# see Briar/jenkins-calabash.sh

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))
require File.expand_path(File.join(File.dirname(__FILE__), 'run-develop'))

# These device sets include a small number high-availability devices. We want
# these XTC tests to be fast because they are kicked off by pull-requests and
# we want feedback ASAP.  Sampling from three sets in an attempt to avoid
# waiting.
xtc_device_set = ARGV[0] || ['d1f3c489', '759f1ce9', 'f20adc7c'].sample
xtc_profile = ARGV[1] || 'default'
# accept 2 additional cucumber args for -t < tags >
cucumber_args = ''
if ARGV.count == 4
  cucumber_args = "#{ARGV[2]} #{ARGV[3]}"
end

run_develop xtc_device_set, xtc_profile, 'pull-requests'

working_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'Briar'))

Dir.chdir working_dir do

  # sometimes json 1.8.1 cannot be found
  install_gem 'json'

  do_system("./jenkins-calabash.sh #{cucumber_args}")
end
