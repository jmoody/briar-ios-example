#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))
require File.expand_path(File.join(File.dirname(__FILE__), 'run-masters'))

xtc_device_set = ARGV[0] || 'toolchain-masters'
xtc_profile = ARGV[1] || 'default'

run_masters xtc_device_set, xtc_profile, 'toolchain-masters'
