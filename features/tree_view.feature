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

Scenario: Expanding items by index
  When I expand the tree item with index "0"
  Then the available tree items should be:
  | Tree Items  |
  | Parent One  |
  | Child 1     |
  | Child 2     |
  | Parent Two  |

Scenario: Expanding items by value
  When I expand the tree item "Parent One"
  Then the available tree items should be:
  | Tree Items  |
  | Parent One  |
  | Child 1     |
  | Child 2     |
  | Parent Two  |

Scenario: Collapsing items by index
  When I expand the tree item "Parent One"
  And I collapse the tree item with index "0"
  Then the available tree items should be:
  | Tree Items  |
  | Parent One  |
  | Parent Two  |

Scenario: Collapsing items by value
  When I expand the tree item "Parent One"
  And I collapse the tree item "Parent One"
  Then the available tree items should be:
  | Tree Items  |
  | Parent One  |
  | Parent Two  |
