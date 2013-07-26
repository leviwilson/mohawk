Feature:  Working with tab controls

  Background:
    Given we are looking at the about screen

  Scenario: Getting the currently selected tab
    Then we know that the currently selected tab is "Info"

  Scenario: Getting the available tabs
    Then we know that the available tabs are "Info, Other Info"