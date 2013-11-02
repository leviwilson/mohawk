@uia
Feature:  Working with controls

  Scenario: Getting and setting the value of value controls
    When I set the "value control field" to the value "12/25/2012"
    Then the value of the "value control field" control should be "12/25/2012 12:00:00 AM"

  Scenario: Clicking controls
    When I click the control identified by "about_control"
    Then the "About" screen should be shown
