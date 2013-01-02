Feature:  Working with tables

Background:
  Given we are observing the people table

Scenario: Selecting a row by index
  When we select the table row with index "1"
  Then the row with index "1" should be selected

Scenario: Selecting a row by value
  When we select the table row with the value "Anna Doe"
  Then the row with index "1" should be selected

Scenario: Rows have cells
  Then the row with index "0" should look like the following:
    | Name      | Date of Birth | State |
    | John Doe  | 12/15/1967    | FL    |

Scenario: Retrieving the row values
  Then the table row information should look like the following:
    | text      | row |
    | John Doe  | 0   | 
    | Anna Doe  | 1   |
