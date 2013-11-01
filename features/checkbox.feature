@uia
Feature:  Working with checkbox controls

Scenario: Setting the checkbox
  When I check the "first checkbox"
  Then the "first checkbox" should be checked

Scenario: Clearing the checkbox
  When I uncheck the "first checkbox"
  Then the "first checkbox" should not be checked

Scenario: Getting the value of the checkbox
  Then I know that the "first checkbox" value is "checkBox"
