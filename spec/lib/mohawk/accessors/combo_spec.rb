require 'spec_helper'

class ComboBoxScreen
  include Mohawk
  window(:id => nil)
  
  combo_box(:nacho_combos, :id => "comboBoxId")
end

class Option
  def initialize(text)
    @text = text
  end

  def text
    @text
  end
end

describe Mohawk::Accessors::Combo do
  let(:screen) { ComboBoxScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:combo_box_field) { double("ComboBox Field") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:select_list).with(:id => "comboBoxId").and_return(combo_box_field)
  end

  context "accessing combo box controls" do

    it "knows the current selected item" do
      combo_box_field.should_receive(:value).and_return("Selected Item")
      screen.nacho_combos.should eq("Selected Item")
    end

    it "selects items by index" do
      combo_box_field.should_receive(:select).with(3)
      screen.nacho_combos = 3
    end

    it "selects items by value" do
      combo_box_field.should_receive(:set).with("Desired Value")
      screen.nacho_combos = "Desired Value"
    end

    it "is aware of the available options" do
      options = [Option.new("first"), Option.new("second"), Option.new("third")]
      combo_box_field.should_receive(:options).and_return(options)
      screen.nacho_combos_options.should eq(["first", "second", "third"])
    end

  end
end

