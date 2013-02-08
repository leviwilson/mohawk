When /^we decide to go a roundabout way to the datagrid$/ do
  navigate_to(DataEntryForm)
end
                                                                   
Then /^we should still arrive at our destination$/ do
  on(DataEntryForm).should be_active
end

When /^we give extra navigational information to a screen$/ do
  @which_screen = on(MainScreen, :pid => @process.pid)
end
                                                                   
Then /^it should listen to every word that we say$/ do
  @which_screen.should be_present
end
