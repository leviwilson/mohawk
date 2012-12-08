Feature:  Working with tables

Background:
  Given we are observing the people table

Scenario: Selecting a row by index
  When we select the table row with index "1"
  Then the row with index "1" should be selected

Scenario: Retrieving the row values
  Then the table row information should look like the following:
    | text      | row |
    | John Doe  | 0   | 
    | Anna Doe  | 1   |
