Feature:  Working with TreeView controls

Scenario: Selecting an item by index
  When I select the item with index "1" in the TreeView
  Then the selected TreeView value should be "Parent Two"

Scenario: Selecting an item by value
  When I select the item "Parent Two" in the TreeView
  Then the selected TreeView value should be "Parent Two"

Scenario: Can reveal the available items
  Then the available tree items should be:
  | Tree Items  |
  | Parent One  |
  | Parent Two  |
