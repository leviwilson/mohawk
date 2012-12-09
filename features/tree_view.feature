Feature:  Working with TreeView controls

Scenario: Selecting an item by index
  When I select the item with index "1" in the TreeView
  Then the selected TreeView value should be "Parent Two"
