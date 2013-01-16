require 'spec_helper'

class LabelScreen
	include Mohawk
	
	window(:title => nil)
	label(:label_control, :id => "labelID")
end

describe Mohawk::Accessors::Label do
	let(:screen) { LabelScreen.new }
	let(:window) { double("RAutomation Window") }
	let(:label_control) { double("Label Control") }
	
	before(:each) do
		RAutomation::Window.stub(:new).and_return(window)
		window.should_receive(:label).with(:id => "labelID").and_return(label_control)
	end
	
	it "can retrieve the label value" do
		label_control.should_receive(:value).and_return("some string")
		screen.label_control.should eq("some string")
	end

  it "can dish out the view" do
    screen.label_control_view.should eq(label_control)
  end

end
