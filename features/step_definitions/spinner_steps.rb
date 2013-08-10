Then(/^I can set the spinner to "([^"]*)"$/) do |value|
  on(MainScreen) do |screen|
    screen.spinner = value.to_f
    screen.spinner.should eq(value.to_f)
  end
end

When(/^the spinner is set to "([^"]*)"$/) do |value|
  on(MainScreen).spinner = value.to_f
end

Then(/^we can crank it up to "([^"]*)"$/) do |expected_value|
  on(MainScreen) do |screen|
    screen.increment_spinner.should eq(expected_value.to_f)
  end
end