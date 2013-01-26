When /^we decide to go a roundabout way to the datagrid$/ do
  navigate_to(DataEntryForm)
end
                                                                   
Then /^we should still arrive at our destination$/ do
  on(DataEntryForm).should be_active
end
