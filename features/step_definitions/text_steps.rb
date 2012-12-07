When /^I set the "(.*)" to the value "(.*)"$/ do |name, value|
  on(MainScreen).send "#{name.to_field}=", value
end

When /^I enter into "(.*?)" the values "(.*?)"$/ do |name, value|
  on(MainScreen).send "enter_#{name.to_field}", value
end

When /^I clear the "(.*)"$/ do |name|
  on(MainScreen).send "clear_#{name.to_field}"
end

Then /^the "(.*)" should be "(.*)"$/ do |name, value|
  on(MainScreen).send("#{name.to_field}").should eq(value)
end
