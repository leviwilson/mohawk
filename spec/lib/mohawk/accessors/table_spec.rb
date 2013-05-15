require 'spec_helper'

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
      first_row = FakeTableRow.new "First Row", 0
      second_row = FakeTableRow.new "Second Row", 1
      expected_rows = [first_row, second_row].map {|r| {:text => r.text, :row => r.row} }
      table.should_receive(:row_count).and_return(2)
      RAutomation::Adapter::MsUia::Row.should_receive(:new).with(table, :index => 0).and_return(first_row)
      RAutomation::Adapter::MsUia::Row.should_receive(:new).with(table, :index => 1).and_return(second_row)
      screen.top.map(&:to_hash).should eq(expected_rows)
    end

    it "has headers" do
      expected_headers = ["first header", "second header"]
      table.should_receive(:search_information).and_return(1234)
      RAutomation::Adapter::MsUia::UiaDll.should_receive(:table_headers).with(1234).and_return(expected_headers)
      screen.top_headers.should eq(expected_headers)
    end

    it "can return the raw view" do
      screen.top_view.should_not be_nil
    end

    describe Mohawk::Accessors::TableRow do
      let(:table_row) { double("RAutomation TableRow") }

      before(:each) do
        RAutomation::Adapter::MsUia::Row.should_receive(:new).with(table, :index => 0).and_return(table_row)
        table_row.stub(:row).and_return 0
      end

      it "can get an individual row" do
        screen.top[0].should_not be_nil
      end

      it "knows if it is selected" do
        table.should_receive(:selected?).with(0).and_return(true)
        screen.top[0].should be_selected
      end

      it "can be selected" do
        table.should_receive(:select).with(0)
        screen.top[0].select
      end

      it "has cells" do
        expected_cells = [FakeTableRow.new("Item 1", 0), FakeTableRow.new("Item 2", 1)]
        table_row.should_receive(:cells).and_return(expected_cells)
        screen.top[0].cells.should eq expected_cells.map &:text
      end

      it "can get cell values by header name" do
        RAutomation::Adapter::MsUia::UiaDll.should_receive(:table_headers).and_return(["First Header", "Second Header"])
        table.should_receive(:search_information)

        expected_cell = double('RAutomation Cell')
        expected_cell.should_receive(:text).and_return('Item 2')
        RAutomation::Adapter::MsUia::Cell.should_receive(:new).with(table_row, :index => 1).and_return(expected_cell)
        screen.top[0].second_header.should eq("Item 2")
      end

      it "clearly lets you know if a header is not there" do
        RAutomation::Adapter::MsUia::UiaDll.should_receive(:table_headers).and_return(["First Header", "Second Header"])
        table.should_receive(:search_information)
        lambda { screen.top[0].does_not_exist }.should raise_error ArgumentError, "does_not_exist column does not exist in [:first_header, :second_header]"
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
