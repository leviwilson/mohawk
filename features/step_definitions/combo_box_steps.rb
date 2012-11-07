When /^I select index "(.*?)" from the "(.*?)" combo box$/ do |index, name|
  on(MainScreen).send "#{name.to_field}=", index.to_i
end

When /^I select the value "(.*?)" from the "(.*?)" combo box$/ do |index, name|
  on(MainScreen).send "#{name.to_field}=", index
end

Then /^the "(.*?)" option should be selected in the "(.*?)" combo box$/ do |value, name|
  on(MainScreen).send("#{name.to_field}").should eq(value)
end
