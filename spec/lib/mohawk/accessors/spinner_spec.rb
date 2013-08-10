require 'spec_helper'

class SpinnerScreen
  include Mohawk
  window(:id => 123)

  spinner(:price_is_right, :id => 'barker')
end

describe Mohawk::Accessors::Spinner do
  let(:window) { double('RAutomation Window') }
  let(:spinner) { double('RAutomation Spinner') }
  subject { SpinnerScreen.new }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:spinner).with(:id => 'barker').and_return(spinner)
  end

  it 'knows the value' do
    spinner.should_receive(:value).and_return(11.0)
    subject.price_is_right.should eq(11.0)
  end

  it 'can set the value' do
    spinner.should_receive(:set).with(11.0)
    subject.price_is_right = 11.0
  end

  it 'can be incremented' do
    spinner.should_receive(:increment).and_return(11.0)
    subject.increment_price_is_right.should eq(11.0)
  end
end