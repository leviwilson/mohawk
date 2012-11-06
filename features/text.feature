Feature:  Working with text controls

Scenario: Setting and getting text by id
  Given we are using the "MainScreen"
  When I set the text field identified by id to "Some text"
  Then I should see "Some text" in the field identified by id

Scenario: Clearing the text by id
  Given we are using the "MainScreen"
  When I set the text field identified by id to "Some text"
  And I clear the text field
  Then I should see "" in the field identified by id
