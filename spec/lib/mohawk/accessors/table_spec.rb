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

include RAutomation::Adapter::MsUia

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

    context 'selecting a row by hash' do
      it 'selects the row if all values match' do
        TableStubber.stub(table)
          .with_headers('Column One', 'Column Two', 'Column Three')
          .and_row('first', 'something', 'foo')
          .and_row('second', 'another', 'bar')

        table.should_receive(:select).with(1)
        screen.select_top :column_one => 'second', :column_three => 'bar'
      end

      it 'raises if no row is found' do
        TableStubber.stub(table)
        .with_headers('Column One', 'Column Two', 'Column Three')
        .and_row('first', 'something', 'foo')

        lambda { screen.select_top :column_one => 'not found' }.should raise_error "A row with {:column_one=>\"not found\"} was not found"
      end

    end

    it "has rows" do
      TableStubber.stub(table)
        .with_headers("Column")
        .and_row("First Row")
        .and_row("Second Row")

      screen.top.map(&:column).should eq(["First Row", "Second Row"])
    end

    it "has headers" do
      TableStubber.stub(table).with_headers('first header', 'second header')
      screen.top_headers.should eq(['first header', 'second header'])
    end

    it "can return the raw view" do
      screen.top_view.should_not be_nil
    end

    describe Mohawk::Accessors::TableRow do
      before(:each) do
        TableStubber.stub(table).with_headers('column').and_row('first row')
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
        TableStubber.stub(table)
          .with_headers('first', 'second')
          .and_row('Cell 1', 'Cell 2')

        screen.top[0].cells.should eq(['Cell 1', 'Cell 2'])
      end

      it "can get cell values by header name" do
        TableStubber.stub(table)
          .with_headers('First Header', 'Second Header')
          .and_row('Item 1', 'Item 2')

        screen.top[0].second_header.should eq('Item 2')
      end

      it "clearly lets you know if a header is not there" do
        TableStubber.stub(table)
          .with_headers('First Header', 'Second Header')
          .and_row('Item 1', 'Item 2')

        lambda { screen.top[0].does_not_exist }.should raise_error ArgumentError, 'does_not_exist column does not exist in [:first_header, :second_header]'
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
