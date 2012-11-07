require 'spec_helper'

class RadioScreen
  include Fado
  window(:id => nil)

  radio(:radio_radio, :id => "radioId")
end

describe Fado::Accessors::Radio do
  let(:screen) { RadioScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:radio_control) { double("Elvis Costello's Radio Radio") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:radio).with(:id => "radioId").and_return(radio_control)
  end

  context "working with radio controls" do
    it "can set the radio control" do
      radio_control.should_receive(:set)
      screen.radio_radio
    end

    it "knows if the radio is selected" do
      radio_control.should_receive(:set?)
      screen.radio_radio?
    end
  end
end
