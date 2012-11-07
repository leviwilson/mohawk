require 'spec_helper'

class TextScreen
  include Fado
  window(:id => nil)
  
  text(:text_id, :id => "textId")
end

describe Fado::Accessors::Text do
  let(:screen) { TextScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:text_field) { double("Text Field") }

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

  end
end
