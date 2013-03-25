require 'spec_helper'

class ControlScreen
  include Mohawk
  window(:id => nil)

  control(:control_yourself, :id => "controlId")
end

describe Mohawk::Accessors::Control do
  let(:screen) { ControlScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:control) { double("Control Window") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:value_control).with(:id => 'controlId').and_return(control)
  end

  it "can get the value" do
    control.should_receive(:value).and_return('expected value')
    screen.control_yourself_value.should eq('expected value')
  end

  it "can set the value" do
    control.should_receive(:set).with('new value')
    screen.control_yourself = 'new value'
  end
end
