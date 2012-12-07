When /^observing the "(.*?)" table$/ do |name|
  on(MainScreen).data_entry_form_button
  on(DataEntryForm) do |screen|
    @table_name = name.to_field
    @table_rows = screen.send "#{name.to_field}_rows"
  end
end

Then /^the table row information should look like the following:$/ do |row_items|
  row_items.map_column!("row") { |r| r.to_i }
  row_items.map_headers!("text" => :text, "row" => :row)
  @table_rows.should eq row_items.hashes
end                                                                                  
