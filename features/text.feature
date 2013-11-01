Feature:  Working with text controls

@uia
Scenario: Setting and getting text
  When I set the "text field" to the value "Some text"
  Then the "text field" should be "Some text"

@uia
Scenario: Clearing text
  When I set the "text field" to the value "Text to be cleared"
  And I clear the "text field"
  Then the "text field" should be ""

Scenario: Entering text
  When I enter into "masked text field" the values "abc12345willnotgoin6789"
  Then the "masked text field" should be "123-45-6789"
