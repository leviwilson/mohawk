When /^I select the item with index "(.*?)" in the TreeView$/ do |which_index|
  on(MainScreen).tree_view = which_index.to_i
end

When /^I select the item "(.*?)" in the TreeView$/ do |expected_value|
  on(MainScreen).tree_view = expected_value
end

Then /^the selected TreeView value should be "(.*?)"$/ do |expected_value|
  on(MainScreen).tree_view.should eq expected_value
end
