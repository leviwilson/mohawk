require 'spec_helper'

class ComboBoxScreen
  include Fado
  window(:id => nil)
  
  combo_box(:nacho_combos, :id => "comboBoxId")
end

describe Fado::Accessors do
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

  end
end

