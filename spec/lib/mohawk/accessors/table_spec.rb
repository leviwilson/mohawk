require 'spec_helper'
require 'ffi'

class TableScreen
  include Mohawk
  window(:id => nil)

  table(:top, :id => "tableId")

  # aliases
  table(:my_default, :id => "defaultAliasId")
  listview(:my_listview, :id => "listviewAliasId")
  list_view(:my_list_view, :id => "list_viewAliasId")
end

class FakeTableRow
  attr_reader :text, :row
  def initialize(text, row)
    @text = text
    @row = row
  end
end

module FFI
  module Library
    def ffi_lib(*names)
    end

    def ffi_libraries
    end

    def attach_function(name, func, args, returns = nil, options = nil)
    end
  end
end

describe Mohawk::Accessors::Table do
  let(:screen) { TableScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:table) { double("Table") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
  end

  context "working with table controls" do
    before(:each) do
      window.should_receive(:table).with(:id => "tableId").and_return(table)
    end

    it "can select a row by index" do
      table.should_receive(:select).with(1)
      screen.top = 1
    end

    it "can select a row by value" do
      table.should_receive(:select).with "John Elway"
      screen.top = "John Elway"
    end

    it "has rows" do
      fake_rows = [FakeTableRow.new("First Row", 0), FakeTableRow.new("Second Row", 1)]
      expected_rows = fake_rows.map {|r| {:text => r.text, :row => r.row} }
      table.should_receive(:rows).and_return(fake_rows)
      screen.top.map(&:to_hash).should eq(expected_rows)
    end

    it "has headers" do
      expected_headers = ["first header", "second header"]
      table.should_receive(:hwnd).and_return(1234)
      RAutomation::Adapter::MsUia::UiaDll.should_receive(:table_headers).with(1234).and_return(expected_headers)
      screen.top_headers.should eq(expected_headers)
    end

    it "can return the raw view" do
      screen.top_view.should_not be_nil
    end

    describe Mohawk::Accessors::TableRow do
      let(:table_row) { double("RAutomation TableRow") }

      before(:each) do
        table.should_receive(:row).with(:index => 0).and_return(table_row)
        table_row.stub(:row).and_return 0
      end

      it "can get an individual row" do
        screen.top[0].should_not be_nil
      end

      it "knows if it is selected" do
        table.should_receive(:selected?).with(0).and_return(true)
        screen.top[0].should be_selected
      end

      it "has cells" do
        expected_cells = [FakeTableRow.new("Item 1", 0), FakeTableRow.new("Item 2", 1)]
        table_row.should_receive(:cells).and_return(expected_cells)
        screen.top[0].cells.should eq expected_cells.map &:text
      end

      it "can get cell values by header name" do
        RAutomation::Adapter::MsUia::UiaDll.should_receive(:table_headers).and_return(["First Header", "Second Header"])
        table.should_receive(:hwnd)
        expected_cells = [FakeTableRow.new("Item 1", 0), FakeTableRow.new("Item 2", 1)]
        table_row.should_receive(:cells).and_return(expected_cells)
        screen.top[0].second_header.should eq("Item 2")
      end
    end
  end

  context "aliases for table" do
    let(:null_table) { double("Null ComboBox Field").as_null_object }
    let(:table_aliases) { ["default", "listview", "list_view"] }

    def expected_alias(id)
      window.should_receive(:table).with(:id => "#{id}AliasId").ordered.and_return(null_table)
    end

    it "has many aliases" do
      table_aliases.each do |which_alias|
        expected_alias which_alias
      end

      table_aliases.each do |which_alias|
        screen.send "my_#{which_alias}_view"
      end
    end
  end
end
