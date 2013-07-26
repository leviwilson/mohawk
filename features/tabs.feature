Feature:  Working with tab controls

  Background:
    Given we are looking at the about screen

  Scenario: Getting the currently selected tab
    Then we know that the currently selected tab is "Info"

  Scenario: Getting the available tabs
    Then we know that the available tabs are "Info, Other Info"

  Scenario: Selecting tabs by index
    When we select the tab at index "1"
    Then we know that the currently selected tab is "Other Info"

  Scenario: Selecting tabs by their values
    When we select the tab with the text "Other Info"
    Then we know that the currently selected tab is "Other Info"

  Scenario: Selecting tabs by a regex
    When we select the tab with the regex "[Oo]ther?\sInfo$"
    Then we know that the currently selected tab is "Other Info"
