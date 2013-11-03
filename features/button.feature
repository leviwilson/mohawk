Feature:  Working with button controls

Scenario: Clicking buttons
  When I click the "Data Entry Form" button
  Then I should see the "DataEntryForm" window

Scenario: Getting button values
  When I look at the value of the "Data Entry Form button" control
  Then the value should be "Data Entry Form"

