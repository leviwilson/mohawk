Then /^I know that the "(.*?)" has the value "(.*?)"$/ do |name, value|
	on(MainScreen).send(name.to_field).should eq(value)
end

When /^I click the "([^"]*)"$/ do |name|
  on(MainScreen).send("click_#{name.to_field}")
end