#!/usr/bin/env ruby

# feel free to improve on this
ident_path = File.expand_path('~/.xamarin/ios-resign/default/signing-identity')

if File.exists?(ident_path)
  ident = File.open(ident_path) {|f| f.readline.chomp.strip }
else
  ident = ARGV[0]
end

lib_path = ARGV[1]

if ident.nil? or ident.length == 0
  puts "WARN: cannot sign with ident = '#{ident}'"
  puts 'WARN: will not sign the Reveal library'
  exit 0
end


unless File.exists?(lib_path)
  puts 'WARN: cannot find a file at path:'
  puts "WARN: '#{lib_path}'"
  puts 'WARN: will not sign the Reveal library'
  exit 0
end


cmd = "xcrun codesign -fs \"#{ident}\" \"#{lib_path}\""
puts "INFO: signing reveal with '#{cmd}'"

exec(cmd)
