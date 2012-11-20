require 'spec_helper'

class TestScreen
  include Mohawk
  window(:title => "Some Window Title")
  
  text(:text_id, :id => "textId")
end

describe Mohawk do
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

    it "knows if a window is active or not" do
      window.should_receive(:active?)
      screen.active?
    end

    it "knows if the window is present" do
      window.should_receive(:present?)
      screen.present?
    end
    
  end
end
