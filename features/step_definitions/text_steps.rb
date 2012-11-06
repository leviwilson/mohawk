When /^I set the text field identified by id to "(.*?)"$/ do |the_text|
  @screen.text_field_by_id = the_text
end

Then /^I should see "(.*?)" in the field identified by id$/ do |the_text|
  @screen.text_field_by_id.should eq(the_text)
end
