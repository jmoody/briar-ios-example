#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'ci-helpers'))

def run_develop(xtc_device_set, xtc_profile, xtc_series)

  do_system(File.expand_path(File.join(File.dirname(__FILE__), 'ci-prepare.rb')))

  working_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'Briar'))

  Dir.chdir working_dir do

    # sometimes json 1.8.1 cannot be found
    install_gem 'json'

    do_system('rm -rf run_loop')
    do_system('git clone --depth 1 --branch develop --recursive https://github.com/calabash/run_loop')
    run_loop_gem_dir = File.expand_path(File.join(working_dir, 'run_loop'))
    Dir.chdir run_loop_gem_dir do
      do_system('bundle install')
      do_system('rake install')
    end

    do_system('rm -rf calabash-ios')
    do_system('git clone --depth 1 --recursive https://github.com/calabash/calabash-ios')
    calabash_gem_dir = File.expand_path(File.join(working_dir, 'calabash-ios'))
    Dir.chdir "#{calabash_gem_dir}/calabash-cucumber" do

      do_system 'touch calabash.framework'
      do_system('zip -r calabash.framework.zip calabash.framework',
                {:pass_msg => 'zipped calabash.framework',
                 :fail_msg => 'could not zip calabash.framework'})

      do_system 'mkdir -p staticlib'
      do_system 'mv calabash.framework.zip staticlib/'
      do_system 'rm calabash.framework'

      do_system('touch staticlib/calabash.framework.zip',
                {:pass_msg => 'installed (empty) staticlib/calabash.framework.zip',
                 :fail_msg => 'could not install (empty) staticlib/calabash.framework.zip'})

      do_system('touch staticlib/libFrankCalabash.a',
                {:pass_msg => 'installed (empty) staticlib/libFrankCalabash.a',
                 :fail_msg => 'could not install (empty) staticlib/libFrankCalabash.a'})

      do_system('mkdir -p dylibs')
      do_system('touch dylibs/libCalabashDynSim.dylib',
                {:pass_msg => 'installed (empty) dylibs/libCalabashDynSim.dylib',
                 :fail_msg => 'could not install (empty) dylibs/libCalabashDynSim.dylib'})
      do_system('touch dylibs/libCalabashDyn.dylib',
                {:pass_msg => 'installed (empty) dylibs/libCalabashDyn.dylib',
                 :fail_msg => 'could not install (empty) dylibs/libCalabashDyn.dylib'})

      do_system('bundle install')
      do_system('rake install')
    end

    briar_repo_name = 'briar-gem'
    do_system("rm -rf #{briar_repo_name}")
    do_system("git clone --depth 1 --recursive https://github.com/jmoody/briar #{briar_repo_name}")
    briar_gem_dir = File.expand_path(File.join(working_dir, briar_repo_name))
    Dir.chdir briar_gem_dir do
      gemspec = 'briar.gemspec'
      IO.write(gemspec, File.open(gemspec) { |f| f.read.gsub(/'calabash-cucumber', (.*)/, "'calabash-cucumber', '>= 0.10.0.pre5'") })
      do_system('bundle install')
      do_system('rake install')
    end

    do_system('rm -rf calabash-ios-server')
    do_system('git clone --depth 1 --recursive https://github.com/calabash/calabash-ios-server')
    server_dir = File.expand_path(File.join(working_dir, 'calabash-ios-server'))

    FileUtils.mkdir_p('.bundle')

    File.open('.bundle/config', 'w') do |file|
      file.write("---\n")
      file.write("BUNDLE_LOCAL__CALABASH-CUCUMBER: \"#{calabash_gem_dir}\"\n")
      file.write("BUNDLE_LOCAL__BRIAR: \"#{briar_gem_dir}\"\n")
      file.write("BUNDLE_LOCAL__RUN_LOOP: \"#{run_loop_gem_dir}\"\n")
    end

    do_system('cp Gemfile.develop Gemfile')

    do_system('bundle install')

    # noinspection RubyStringKeysInHashInspection
   env_vars =
         {
               'CALABASH_SERVER_PATH' => server_dir,
               'CALABASH_GEM_PATH' => calabash_gem_dir,
         }

    File.open('.env', 'a') { |f|
      f.write("XTC_SERIES=\"#{xtc_series}\"\n")
    }

    do_system('bundle exec briar install calabash-server',
              {:env_vars => env_vars})

    #do_system("bundle exec briar xtc #{xtc_device_set} #{xtc_profile}")

  end
end
