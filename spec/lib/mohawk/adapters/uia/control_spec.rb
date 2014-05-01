require 'spec_helper'

describe Mohawk::Adapters::UiaAdapter::Control do
  let(:adapter) { double(window: window) }
  let(:window) { double(element: parent) }
  let(:parent) { double(find: element) }
  let(:element) { double('uia element') }

  def new_control(locator)
    Mohawk::Adapters::UiaAdapter::Control.new adapter, locator
  end

  Given(:control) { new_control(id: 'whatever') }

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

  class HasControl < Mohawk::Adapters::UiaAdapter::Control
    valid_control_types :this, :that
  end

  context '#control_types' do
    Given { parent.stub(:find) {|l| @locator = l } }
    Given(:no_filter) { new_control(id: 'hi') }
    Given(:some_filter) { HasControl.new adapter, id: 'hi' }
    Given(:overridden) { HasControl.new adapter, id: 'hi', control_type: :overridden }

    def control_type(control)
      control.exist?
      @locator.delete(:control_type)
    end

    Then { control_type(no_filter) == nil }
    Then { control_type(some_filter) == [:this, :that] }
    Then { control_type(overridden) == :overridden }
  end
end
