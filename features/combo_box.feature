Feature:  Working with combo boxes

Scenario: Selecting items by index
  When I select index "2" from the "fruits" combo box
  Then the "Coconut" option should be selected in the "fruits" combo box
