Feature:  Working with combo boxes

Scenario: Selecting items by index
  When I select index "2" from the "fruits" combo box
  Then the "Coconut" option should be selected in the "fruits" combo box

Scenario: Selecting items by value
  When I select the value "Orange" from the "fruits" combo box
  Then the "Orange" option should be selected in the "fruits" combo box

Scenario: Getting the available options
  When I look at the options for the "fruits" combo box"
  Then I should see the following options:
  | Option        |
  | Apple         |
  | Caimito       |
  | Coconut       |
  | Orange        |
  | Passion Fruit |
