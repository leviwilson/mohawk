Then /^I know that the "(.*?)" has the value "(.*?)"$/ do |name, value|
	on(MainScreen).send(name.to_field).should eq(value)
end