require 'spec_helper'

class TableScreen
  include Mohawk
  window(:id => nil)

  table(:top, :id => "tableId")
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
    window.should_receive(:table).with(:id => "tableId").and_return(table)
  end

  it "can set a value by index" do
    table.should_receive(:select).with(1)
    screen.top = 1
  end

  it "can set a value by text" do
    table.should_receive(:set).with("Some item")
    screen.top = "Some item" end

  it "has rows" do
    fake_rows = [FakeTableRow.new("First Row", 0), FakeTableRow.new("Second Row", 1)]
    expected_rows = fake_rows.map {|r| {:text => r.text, :row => r.row} }
    table.should_receive(:rows).and_return(fake_rows)
    expected_rows.should eq(screen.top_rows)
  end
end
