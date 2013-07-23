require 'securerandom'

class TableStubber
  include RSpec::Mocks::ExampleMethods

  attr_reader :table, :rows

  def initialize(table)
    @table = table
    @id = SecureRandom.base64
    @table.stub(:search_information).and_return(@id)
    @rows = []
  end

  def self.stub(table)
    TableStubber.new(table)
  end

  def with_headers(*headers)
    UiaDll.stub(:table_headers).with(@id).and_return(headers.map(&:to_s))
    self
  end

  def and_row(*values)
    stub_cells_for(add_row, values)
    self
  end

  private
  def add_row
    row = double("table #{@id}, row #{rows.count}")
    row.stub(:row).and_return(rows.count)
    Row.stub(:new).with(table, :index => rows.count).and_return(row)
    rows << row
    table.stub(:row_count).and_return(rows.count)
    row
  end

  def stub_cells_for(row, values)
    values.each_with_index do |value, index|
      cell = double("Cell at #{row.row}, #{index}")
      Cell.stub(:new).with(row, :index => index).and_return(cell)
      cell.stub(:text).and_return(value)
    end
  end
end