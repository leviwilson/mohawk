When /^we are using the "(.*?)"$/ do |expected_screen|
  @screen = on(expected_screen.to_class)
end

Then /^the window should exist$/ do
  @screen.should exist
end

Then /^we know that the window is active$/ do
  @screen.should be_active
end
