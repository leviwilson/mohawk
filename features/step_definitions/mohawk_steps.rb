When /^we are using the "(.*?)"$/ do |expected_screen|
  @screen = on(expected_screen.to_class)
end

Then /^the window should exist$/ do
  @screen.should exist
end

Then /^we know that the window is active$/ do
  @screen.should be_active
end

Then /^we can confirm the window has the text "(.*?)"$/ do |what_text|   
  @screen.should have_text(what_text)
end                                                                 

Then /^we can wait for the control with a value of "(.*?)"$/ do |value|   
  @screen.wait_for_control :value => value
end

Then /^our parent is the container, not the main window$/ do
  @screen.adapter.window.title.should_not match(/MainForm/)
  @screen.up_view.control_name.should eq('Forward')
end

When(/^we tell the screen to limit searches to children only$/) do
  on(MainScreen).data_grid
  on(ScreenScopedToChildren).should be_active
end

Then(/^we notice a performance increase, especially when data grid views are involved$/) do
  start = Time.now
  on(ScreenScopedToChildren).close
  (Time.now - start).should be < 2
end