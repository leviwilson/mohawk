Given(/^we are looking at the about screen$/) do
  on(MainScreen).about
end

Then(/^we know that the currently selected tab is "([^"]*)"$/) do |expected_tab|
  on(AboutScreen).tab.should eq(expected_tab)
end

Then(/^we know that the available tabs are "([^"]*)"$/) do |tabs|
  on(AboutScreen).tab_items.should eq(tabs.split(', '))
end

When(/^we select the tab at index "([^"]*)"$/) do |tab_index|
  on(AboutScreen).tab = tab_index.to_i
end

When(/^we select the tab with the text "([^"]*)"$/) do |which|
  on(AboutScreen).tab = which
end
