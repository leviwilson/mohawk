When /^I click the "(.*?)" button$/ do |name|
  on(MainScreen).send "#{name.to_field}_button"
end

Then /^I should see the "(.*?)" window$/ do |window_title|
  RAutomation::Window.new(:title => window_title).wait_until_exists
end

When /^I look at the value of the "(.*?)" control$/ do |name|
  @last_value = on(MainScreen).send "#{name.to_field}_value"
end

Then /^the value should be "(.*?)"$/ do |value|
  @last_value.should eq(value)
end
