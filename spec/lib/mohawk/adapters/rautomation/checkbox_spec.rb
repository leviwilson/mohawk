require 'spec_helper'

class CheckboxScreen
  include Mohawk
  window(:id => nil)

  checkbox(:check_yourself, :id => "checkboxId")
end

describe Mohawk::Adapters::RAuto::CheckBox do
  let(:screen) { CheckboxScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:checkbox_field) { double("CheckBox Field") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:checkbox).with(:id => "checkboxId").and_return(checkbox_field)
  end

  context "accessing checkbox controls" do

    it "knows if something is checked" do
      checkbox_field.should_receive(:set?).and_return(true)
      screen.check_yourself.should be_true
    end

    it "can get the text of the checkbox" do
      checkbox_field.should_receive(:value).and_return("CheckBox Text")
      screen.check_yourself_value.should eq("CheckBox Text")
    end

    it "can check items" do
      checkbox_field.should_receive(:set)
      screen.check_yourself = true
    end

    it "can uncheck items" do
      checkbox_field.should_receive(:clear)
      screen.check_yourself = false
    end

    it "can dish out the raw control" do
      screen.check_yourself_view.should be(checkbox_field)
    end
  end
end
