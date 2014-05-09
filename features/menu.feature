Feature:  Working with menu items

Scenario: Selecting a menu item by text
  When I select the menu item by text
  Then I should see the "About" window

Scenario: Selecting an item from the menu
  When I select the menu item in the path "File | Roundabout Way | To | About"
  Then I should see the "About" window

Scenario: Clicking an item from the menu
  When I click the menu item in the path "File | Roundabout Way | To | About"
  Then I should see the "About" window
