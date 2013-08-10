Then(/^I can set the spinner to "([^"]*)"$/) do |value|
  on(MainScreen) do |screen|
    screen.spinner = value.to_f
    screen.spinner.should eq(value.to_f)
  end
end