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

When(/^we add rows "([^"]*)" to the selection$/) do |which_rows|
  on(DataEntryForm) do |screen|
    which_rows.split(', ').map(&:to_i).each do |row|
      screen.people = row
    end
  end
end

When(/^we clear rows "([^"]*)" from the selection$/) do |which_rows|
  on(DataEntryForm) do |screen|
    which_rows.split(', ').map(&:to_i).each do |row|
      screen.clear_people(row)
    end
  end
end

Then(/^rows "([^"]*)" should all (not )?be selected$/) do |which_rows, to_not_be|
  should_or_should_not = (to_not_be && :should_not) || :should
  on(DataEntryForm) do |screen|
    which_rows.split(', ').map(&:to_i).each do |row|
      screen.people[row].send(should_or_should_not, be_selected)
    end
  end
end

When(/^we (select|clear) the table row with the following information:$/) do |select_or_clear, table|
  on(DataEntryForm).send("#{select_or_clear}_people", table.hashes.first)
end

Then(/^we can find the row with the following information:$/) do |table|
  expected_info = table.hashes.first
  actual_info = on(DataEntryForm).find_people expected_info
  expected_info.each do |key, value|
    actual_info.send(key).should eq(value)
  end
end

When /^we select the "(.*?)"th table row$/ do |index|
  on(DataEntryForm).people[index.to_i].select
end

Then /^the row with index "(.*?)" should (not )?be selected$/ do |which_row, to_not_be|
  should_or_should_not = (to_not_be && :should_not) || :should
  on(DataEntryForm).people[which_row.to_i].send(should_or_should_not, be_selected)
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

When(/^there are a lot of records in a table$/) do
  on(DataEntryForm) do |screen|
    5.times { screen.add_more }
  end
end

Then(/^the table count responds in a reasonable amount of time$/) do
  Timeout.timeout(5.0) { on(DataEntryForm).people.count.should eq(252) }
end

Then(/^accessing the values in row "([^"]*)" should be snappy$/) do |which_row|
  Timeout.timeout(5.0) { on(DataEntryForm).people[which_row.to_i].cells.should_not be_empty }
end
