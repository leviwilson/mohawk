require 'spec_helper'

class TestScreen
  include Fado
  window(:title => "Some Window Title")
end

describe Fado do
  let(:screen) { TestScreen.new }
  let(:window) { double('RAutomation Window') }

  before(:each) do
    #RAutomation::Window.stub(:new).and_return(window)
  end

  context "using the UI Automation adapter" do
    it "should force :ms_uia" do
      RAutomation::Window.should_receive(:new).with(:title => "Some Window Title", :adapter => :ms_uia).and_return(window)
      TestScreen.new
    end
  end
end
