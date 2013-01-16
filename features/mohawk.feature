Feature:  Using Mohawk

Scenario: Determining if a window exists
  When we are using the "MainScreen"
  Then the window should exist

Scenario: Determining if a window is active
  When we are using the "MainScreen"
  Then we know that the window is active

Scenario: Determining if a window has text
  When we are using the "MainScreen"
  Then we can confirm the window has the text "Assorted UI Elements"
