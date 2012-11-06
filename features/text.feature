Feature:  Working with text controls

Scenario: Setting and getting text
  When I set the "text field" to the value "Some text"
  Then the "text field" should be "Some text"

Scenario: Clearing text
  When I set the "text field" to the value "Text to be cleared"
  And I clear the "text field"
  Then the "text field" should be ""
