Feature:  Working with tables

Scenario: Retrieving the row values
  When observing the "people" table
  Then the table row information should look like the following:
    | text      | row |
    | John Doe  | 0   | 
    | Anna Doe  | 1   |
