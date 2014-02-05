require 'spec_helper'

describe Mohawk::Adapters::UiaAdapter::Control do
  let(:adapter) { double('uia adapter') }
  let(:parent) { double('uia parent') }
  let(:element) { double('uia element') }

  Given(:control) do
    adapter.stub_chain(:window, :element).and_return(parent)
    expect(parent).to receive(:find).and_return element
    Mohawk::Adapters::UiaAdapter::Control.new(adapter, id: 'whatever')
  end

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
