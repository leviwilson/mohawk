require 'spec_helper'

class ControlScreen
  include Mohawk
  window(:id => nil)

  control(:control_yourself, :id => "controlId")
end

describe Mohawk::Adapters::RAuto::Control do
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

  it "can click the control" do
    control.should_receive(:click).and_yield
    screen.click_control_yourself
  end

  it "can give a custom block to the click method" do
    control.should_receive(:click).and_yield
    result = false
    screen.click_control_yourself do
      result = true
    end
    result.should be_true
  end

  it "can work with the raw view" do
    screen.control_yourself_view.should be(control)
  end
end
