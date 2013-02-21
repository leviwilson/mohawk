When /^we are observing the people table$/ do
  on(MainScreen).data_entry_form_button
  on(DataEntryForm).should be_active
end

Then /^the table row information should look like the following:$/ do |row_items|
  row_items.map_column!("row") { |r| r.to_i }
  row_items.map_headers!("text" => :text, "row" => :row)
  on(DataEntryForm).people.map(&:to_hash).should eq row_items.hashes
end

When /^we select the table row with index "(.*?)"$/ do |row_index|
  on(DataEntryForm).people = row_index.to_i
end

When /^we select the table row with the value "([^"]*)"$/ do |row_value|
  on(DataEntryForm).people = row_value
end

When /^we select the "(.*?)"th table row$/ do |index|
  on(DataEntryForm).people[index.to_i].select
end

Then /^the row with index "(.*?)" should be selected$/ do |which_row|
  on(DataEntryForm).people[which_row.to_i].should be_selected
end

Then /^the row with index "(.*?)" should look like the following:$/ do |which_row, table|
  actual_cells = on(DataEntryForm).people[which_row.to_i].cells
  actual_cells.should eq table.rows.first
end

Then /^the table headers are "(.*?)"$/ do |expected_headers|
  on(DataEntryForm).people_headers.should eq(expected_headers.split(", "))
end

Then /^the "(.*?)" for the row at index "(.*?)" is "(.*?)"$/ do |header, which_row, expected_value|
  on(DataEntryForm).people[which_row.to_i].send(header).should eq(expected_value)
end                                                                               
