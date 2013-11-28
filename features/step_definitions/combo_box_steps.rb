When /^I select index(es)? "(.*?)" from the "(.*?)" combo box$/ do |_, indexes, name|
  on(MainScreen) do |screen|
    indexes.split(', ').map(&:to_i).each do |index|
      screen.send "select_#{name.to_field}", index
    end
  end
end

When /^I select the value "(.*?)" from the "(.*?)" combo box$/ do |index, name|
  on(MainScreen).send "#{name.to_field}=", index
end

When(/^I clear the item at index "([^"]*)" from the "([^"]*)" combo box$/) do |which, name|
  on(MainScreen).send("clear_#{name.to_field}", which.to_i)
end

When(/^I clear item "([^"]*)" from the "([^"]*)" combo box$/) do |which, name|
  on(MainScreen).send("clear_#{name.to_field}", which)
end

Then /^the "(.*?)" option(s)? should be selected in the "(.*?)" combo box$/ do |value, has_multiple, name|
  if has_multiple
    on(MainScreen).send("#{name.to_field}_selections").should eq(value.split(', '))
  else
    on(MainScreen).send("#{name.to_field}").should eq(value)
  end
end

When /^I look at the options for the "(.*?)" combo box"$/ do |name|
  @options = on(MainScreen).send("#{name.to_field}_options")
end

Then /^I should see the following options:$/ do |table|
  expected_options = table.hashes.map {|row| row["Option"] }
  @options.should eq(expected_options)
end

Given(/^we toggle the multi-select button$/) do
  on(MainScreen).toggle_multi
end

Then(/^the application should know that "([^"]*)" was selected$/) do |expected_value|
  on(MainScreen).fruits_label.should eq(expected_value)
end