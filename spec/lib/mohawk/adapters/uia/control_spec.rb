require 'spec_helper'

describe Mohawk::Adapters::UiaAdapter::Control do
  let(:adapter) { double(window: window) }
  let(:window) { double(element: parent) }
  let(:parent) { double(find: element) }
  let(:element) { double('uia element') }

  Given(:control) { Mohawk::Adapters::UiaAdapter::Control.new(adapter, id: 'whatever') }

  context 'working with the element directly' do
    context 'passes through if it can' do
      When { expect(element).to receive(:bounding_rectangle).and_return [1, 2, 3, 4] }
      Then { expect(control.bounding_rectangle).to eq [1, 2, 3, 4] }
    end

    context 'fails otherwise' do
      When(:bad_method) { control.does_not_have }
      Then { expect(bad_method).to have_failed NoMethodError }
    end
  end
end
