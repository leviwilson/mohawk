When /^I select the menu item in the path "(.*?)"$/ do |menu_path|        
  menu_item_method = menu_path.gsub(/ (\| )?/, "_").downcase
  on(MainScreen).send menu_item_method
end                                                                  

