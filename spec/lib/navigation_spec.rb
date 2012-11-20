require 'spec_helper'

class NavigationTestScreen
end

include Mohawk::Navigation

describe Mohawk::Navigation do
  let(:screen) { double("Mohawk Screen").as_null_object }

  before(:each) do
    NavigationTestScreen.stub(:new).and_return(screen)
    RAutomation::WaitHelper.stub(:sleep)
  end

  it "can create screen objects" do
    on(NavigationTestScreen).should eq screen
  end

  it "should give the screen to a block if desired" do
    screen.should_receive(:expected_method)
    on(NavigationTestScreen) do |screen|
      screen.expected_method
    end
  end

  it "waits for the screen to be active before proceeding" do
    screen.should_receive(:active?).twice.and_return(false, true)
    screen.should_receive(:was_used)
    on(NavigationTestScreen) do |screen|
      screen.was_used
    end
  end
end
