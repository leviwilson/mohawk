require 'spec_helper'

class ButtonScreen
  include Fado
  window(:id => nil)

  button(:easy, :id => "easyButton")
end

describe Fado::Accessors::Button do
  let(:screen) { ButtonScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:button_field) { double("Button Field") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:button).with(:id => "easyButton").and_return(button_field)
  end

  context "accessing buttons" do

    it "clicks buttons" do
      button_field.should_receive(:click).and_yield
      screen.easy
    end

    it "clicks buttons and yields to a block" do
      button_field.should_receive(:click).and_yield
      result = false
      screen.easy do
        result = true
      end
      result.should be_true
    end

    it "knows the value of the button" do
      button_field.should_receive(:value).and_return "Button Value"
      screen.easy_value.should eq("Button Value")
    end
  end
end
