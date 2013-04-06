
#noinspection RubyUnusedLocalVariable
Before do |scenario|
  if ENV['NO_LAUNCH']
    backdoor('calabashBackdoor:', 'ignorable')
    wait_for_animation
  end
end

#noinspection RubyUnusedLocalVariable
After do |scenario|
  if ENV['EMBED']
    res = http({:method => :get, :path => 'screenshot'})
    image_data = Base64.encode64(res).gsub("\n", "")
    embed("data:image/png;base64,#{image_data}", 'image/png')
  end
end
