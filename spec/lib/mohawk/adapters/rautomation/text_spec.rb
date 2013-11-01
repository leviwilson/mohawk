require 'spec_helper'

class TextScreen
  include Mohawk
  window(:id => nil)
  
  text(:text_id, :id => "textId")
end

describe Mohawk::Adapters::RAuto::Text do
  let(:screen) { TextScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:text_field) { double("Text Field") }
  let(:text_field_window) { double("Text Field Window") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:text_field).with(:id => "textId").and_return(text_field)
  end

  context "accessing text controls" do

    it "sets the text" do
      text_field.should_receive(:set).with("the text value")
      screen.text_id = "the text value"
    end

    it "retrieves the text" do
      text_field.should_receive(:value).and_return("the text")
      screen.text_id.should eq("the text")
    end
    
    it "clears the text" do
      text_field.should_receive(:clear)
      screen.clear_text_id
    end

    it "enters the text" do
      text_field.should_receive(:hwnd).and_return 123
      window.should_receive(:child).with(:hwnd => 123).and_return(text_field_window)
      text_field_window.should_receive(:send_keys).with("entered text".split(//))

      screen.enter_text_id "entered text"
    end

    it "can dish out the text view" do
      screen.text_id_view.should be(text_field)
    end

  end
end
