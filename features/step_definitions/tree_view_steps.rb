When /^I select the item with index "(.*?)" in the TreeView$/ do |which_index|
  on(MainScreen).tree_view = which_index.to_i
end

Then /^the selected TreeView value should be "(.*?)"$/ do |expected_value|
  on(MainScreen).tree_view.should eq expected_value
end
