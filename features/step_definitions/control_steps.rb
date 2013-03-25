Then /^the value of the "([^"]*)" control should be "(.*?)"$/ do |which, what|
  on(MainScreen).send("#{which.to_method}_value").should eq(what)
end