When /^I click the "([^"]*)"$/ do |name|
  on(MainScreen).send("click_#{name.to_field}")
end
