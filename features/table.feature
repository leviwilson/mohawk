Feature:  Working with tables

Background:
  Given we are observing the people table

Scenario: Retrieving the row values
  Then the table row information should look like the following:
    | text      | row |
    | John Doe  | 0   | 
    | Anna Doe  | 1   |
