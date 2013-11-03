Feature:  Working with combo boxes

  Scenario: Selecting items by index
    When I select index "2" from the "fruits" combo box
    Then the "Coconut" option should be selected in the "fruits" combo box

  Scenario: Selecting items by value
    When I select the value "Orange" from the "fruits" combo box
    Then the "Orange" option should be selected in the "fruits" combo box

  Scenario: Selecting multiple items
    Given we toggle the multi-select button
    When I select indexes "0, 1, 2" from the "fruits_list" combo box
    Then the "Apple, Orange, Mango" options should be selected in the "fruits_list" combo box

  Scenario: Clearing items by index
    Given we toggle the multi-select button
    When I select indexes "0, 1, 2" from the "fruits_list" combo box
    But I clear the item at index "1" from the "fruits_list" combo box
    Then the "Apple, Mango" options should be selected in the "fruits_list" combo box

  Scenario: Clearing items by value
    Given we toggle the multi-select button
    When I select indexes "0, 1, 2" from the "fruits_list" combo box
    But I clear item "Mango" from the "fruits_list" combo box
    Then the "Apple, Orange" options should be selected in the "fruits_list" combo box

  Scenario: Getting the available options
    When I look at the options for the "fruits" combo box"
    Then I should see the following options:
      | Option        |
      | Apple         |
      | Caimito       |
      | Coconut       |
      | Orange        |
      | Passion Fruit |
