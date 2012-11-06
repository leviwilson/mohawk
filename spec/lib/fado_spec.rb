require 'spec_helper'

class TestScreen
  include Fado
  window(:title => "Some Window Title")
  
  text(:text_id, :id => "textId")
end

describe Fado do
  let(:screen) { TestScreen.new }
  let(:window) { double('RAutomation Window') }

  it "uses the uia adapter by default" do
    RAutomation::Window.should_receive(:new).with(:title => "Some Window Title", :adapter => :ms_uia).and_return(window)
    TestScreen.new
  end

  context "using the UI Automation adapter" do
    before(:each) do
      RAutomation::Window.stub(:new).and_return(window)
    end

    it "knows if a window exists" do
      window.should_receive(:exist?)
      screen.exist?
    end

    it "can set text by id" do
      text_field = double("Text mock")
      window.should_receive(:text_field).with(:id => "textId").and_return(text_field)
      text_field.should_receive(:set).with("the text value")
      
      screen.text_id = "the text value"
    end

    it "can get the text by id" do
      text_field = double("Text mock")
      window.should_receive(:text_field).with(:id => "textId").and_return(text_field)
      text_field.should_receive(:value).and_return("the text")
      
      screen.text_id.should eq("the text")
    end

    
  end
end
