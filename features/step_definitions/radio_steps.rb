When /^I set the "([^\"]*)"$/ do |name|
  on(MainScreen).send name.to_field
end

Then /^the "(.*?)" should be set$/ do |name|
  on(MainScreen).send("#{name.to_field}?").should be_true
end
