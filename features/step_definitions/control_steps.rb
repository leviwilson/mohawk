Then /^the value of the "([^"]*)" control should be "(.*?)"$/ do |which, what|
  on(MainScreen).send("#{which.to_method}_value").should eq(what)
end

When(/^I click the control identified by "([^"]*)"$/) do |what|
  on(MainScreen).send("click_#{what}")
end

Then(/^the "([^"]*)" screen should be shown$/) do |screen|
  on(AboutScreen).should be_present
end