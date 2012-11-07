When /^I check the "(.*?)"$/ do |name|
  on(MainScreen).send "#{name.to_field}=", true
end

When /^I uncheck the "(.*?)"$/ do |name|
  on(MainScreen).send "#{name.to_field}=", false
end

Then /^the "(.*?)" should be checked$/ do |name|
  on(MainScreen).send("#{name.to_field}").should be_true
end

Then /^the "(.*?)" should not be checked$/ do |name|
  on(MainScreen).send("#{name.to_field}").should be_false
end

Then /^I know that the "(.*?)" value is "(.*?)"$/ do |name, expected_value|
  on(MainScreen).send("#{name.to_field}_value").should eq(expected_value)
end
