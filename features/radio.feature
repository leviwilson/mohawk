@uia
Feature:  Working with radio controls

Scenario: Setting and getting radio button values
  When I set the "first radio"
  Then the "first radio" should be set
