When /^I click the "(.*?)" button$/ do |name|
  on(MainScreen).send "#{name.to_field}_button"
end

Then /^I should see the "(.*?)" window$/ do |window_title|
  RAutomation::Window.new(:title => window_title).should exist
end
