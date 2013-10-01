Feature:  Working with tables

  Background:
    Given we are observing the people table

  Scenario: Selecting a row by index
    When we select the table row with index "1"
    Then the row with index "1" should be selected

  Scenario: Selecting a row by value
    When we select the table row with the value "Anna Doe"
    Then the row with index "1" should be selected

  Scenario: Selecting a row by matching cell information
    When we select the table row with the following information:
      | name     | date_of_birth |
      | Anna Doe | 3/4/1975      |
    Then the row with index "1" should be selected

  Scenario: Finding a row
    Then we can find the row with the following information:
      | name     | date_of_birth | state |
      | John Doe | 12/15/1967    | FL    |

  Scenario: Selecting a row from a child item
    When we select the "1"th table row
    Then the row with index "1" should be selected

  Scenario: Adding rows to the selection
    Given there are a lot of records in a table
    When we add rows "1, 3, 5" to the selection
    Then rows "1, 3, 5" should all be selected

  Scenario: Rows have cells
    Then the row with index "0" should look like the following:
      | Name     | Date of Birth | State |
      | John Doe | 12/15/1967    | FL    |

  Scenario: Retrieving the row values
    Then the table row information should look like the following:
      | text     | row |
      | John Doe | 0   |
      | Anna Doe | 1   |

  Scenario: Retrieving the headers
    Then the table headers are "Name, Date of birth, State"

  Scenario: Retrieving a row value by its header
    Then the "date_of_birth" for the row at index "1" is "3/4/1975"

  Scenario: Working with lots of records counts
    When there are a lot of records in a table
    Then the table count responds in a reasonable amount of time

  Scenario: Working with a row when there are a lot of records
    When there are a lot of records in a table
    Then accessing the values in row "12" should be snappy
