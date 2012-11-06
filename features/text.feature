Feature:  Working with text controls

Scenario: Setting and getting text by id
  Given we are using the "MainScreen"
  When I set the text field identified by id to "Some text"
  Then I should see "Some text" in the field identified by id
