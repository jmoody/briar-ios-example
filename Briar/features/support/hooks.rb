
#noinspection RubyUnusedLocalVariable
Before do |scenario|
  if ENV['NO_LAUNCH']
    backdoor('calabash_backdoor_reset_app:', 'ignorable')
    2.times do
      wait_for_animation
    end
  end
end

#noinspection RubyUnusedLocalVariable
After do |scenario|
  if ENV['EMBED']

    #screenshot_embed(:prefix => "/some/prefix/path", :name => "filename.png", :label => "Cucumber label")

    res = http({:method => :get, :path => 'screenshot'})
    image_data = Base64.encode64(res).gsub("\n", "")
    embed("data:image/png;base64,#{image_data}", 'image/png')
  end
end
