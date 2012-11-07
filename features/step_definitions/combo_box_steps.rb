When /^I select index "(.*?)" from the "(.*?)" combo box$/ do |index, name|
  on(MainScreen).send "#{name.to_field}=", index.to_i
end

When /^I select the value "(.*?)" from the "(.*?)" combo box$/ do |index, name|
  on(MainScreen).send "#{name.to_field}=", index
end

Then /^the "(.*?)" option should be selected in the "(.*?)" combo box$/ do |value, name|
  on(MainScreen).send("#{name.to_field}").should eq(value)
end

When /^I look at the options for the "(.*?)" combo box"$/ do |name|
  @options = on(MainScreen).send("#{name.to_field}_options")
end

Then /^I should see the following options:$/ do |table|
  expected_options = table.hashes.map {|row| row["Option"] }
  @options.should eq(expected_options)
end
