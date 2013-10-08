require 'spec_helper'

describe Mohawk::Accessors::TableRow do
  let(:table) { double('RAutomation Table') }
  let(:adapter) { double('mohawk adapter') }
  let(:mohawk_table) { Mohawk::Accessors::Table.new(adapter, value: 'whatever') }
  let(:stubber) do
    TableStubber.stub(table)
    .with_headers('Name', 'Age')
    .and_row('Levi', '33')
  end

  subject { Mohawk::Accessors::TableRow.new(mohawk_table, 0) }

  before(:each) do
    adapter.stub_chain(:window, :table).and_return(table)
  end

  it '#add_to_selection' do
    stubber.rows[0].should_receive(:select)
    subject.add_to_selection
  end

  it '#select' do
    stubber.should_singly_select_row(0)
    subject.select
  end
end