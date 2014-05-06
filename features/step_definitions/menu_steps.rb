When(/^I select the menu item by text$/) do
  on(MainScreen).menu_item_by_text
end

When /^I (select|click) the menu item in the path "(.*?)"$/ do |select_or_click, menu_path|
  menu_item_method = menu_path.gsub(/ (\| )?/, "_").downcase
  menu_item_method.prepend('click_') if select_or_click == 'click'
  on(MainScreen).send menu_item_method
end

