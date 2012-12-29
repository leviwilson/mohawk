Feature:  Working with link controls

  Scenario: Getting the value of the link
    Then I know that the "link control text" has the value "linkLabel1"

  Scenario: Clicking on the link
    When I click the "link control"
    Then I know that the "link control text" has the value "linkLabel1 (clicked 1 times)"

