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

  it "waits for the screen to be present before proceeding" do
    screen.should_receive(:wait_until_present)
    screen.should_receive(:was_used)
    on(NavigationTestScreen) do |screen|
      screen.was_used
    end
  end

  it "can pass additional locator information to the screen" do
    NavigationTestScreen.should_receive(:new).with(:extra => 'info').and_return(screen)
    on(NavigationTestScreen, :extra => 'info')
  end
end
