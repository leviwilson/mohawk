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

  class HasPattern < Mohawk::Adapters::UiaAdapter::Control
    valid_patterns :this, :that
  end

  context '#patterns' do
    Given { parent.stub(:find) {|l| @locator = l } }
    Given(:no_filter) { new_control(id: 'hi') }
    Given(:some_filter) { HasPattern.new adapter, id: 'hi' }
    Given(:overridden) { HasPattern.new adapter, id: 'hi', pattern: :overridden }

    def pattern(control)
      control.exist?
      @locator.delete(:pattern)
    end

    Then { pattern(no_filter) == nil }
    Then { pattern(some_filter) == [:this, :that] }
    Then { pattern(overridden) == :overridden }
  end
end
