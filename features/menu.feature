Feature:  Working with menu items

Scenario: Selecting an item from the menu
  When I select the menu item in the path "File | Roundabout Way | To | About"
  Then I should see the "About" window
