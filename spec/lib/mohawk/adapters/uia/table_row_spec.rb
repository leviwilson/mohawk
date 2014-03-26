require 'spec_helper'

describe Mohawk::Adapters::UIA::TableRow do
  let(:table) { double 'table Element' }
  let(:element) { double 'row Element' }

  subject { Mohawk::Adapters::UIA::TableRow.new table, element, 123 }

  def set_expected_cells(h)
    element.stub(:items).and_return h.values.map {|v| UiaTableCell.new v }
    table.stub(:headers).and_return h.keys.map(&:to_s)
  end

  context '#all_match?' do
    it 'matches string values' do
      set_expected_cells 'First Column' => 'Yo'

      expect(subject).to be_all_match first_column: 'Yo'
    end

    it 'matches non-string values' do
      set_expected_cells 'Date Field' => Date.today.to_s

      expect(subject).to be_all_match date_field: Date.today
    end
  end

  class UiaTableCell
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
