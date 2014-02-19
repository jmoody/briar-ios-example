#!/usr/bin/ruby

# feel free to improve on this
ident_path = File.expand_path('~/.xamarin/ios-resign/default/signing-identity')

if File.exists?(ident_path)
  ident = File.open(ident_path) {|f| f.readline().chomp.strip }
else
  ident = ARGV[0]
end

lib_path = ARGV[1]

cmd = "codesign -fs \"#{ident}\" \"#{lib_path}\""

puts "INFO: signing reveal with '#{cmd}'"

res = system cmd

if res
  puts 'INFO: successfully signed reveal'
else
  code = `echo $?`
  puts 'ERROR: failed to sign reveal exiting'
  exit code
end
