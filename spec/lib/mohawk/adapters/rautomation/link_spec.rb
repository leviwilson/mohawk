require 'spec_helper'

class LinkScreen
  include Mohawk

  window(:title => nil)
  link(:link_control, :id => "linkID")
end

describe Mohawk::Adapters::RAuto::Link do
  let(:screen) { LinkScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:link_control) { double("Link Control") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:label).with(:id => "linkID").and_return(link_control)
  end

  it "can retrieve the link text" do
    link_control.should_receive(:value).and_return("some string")
    screen.link_control_text.should eq("some string")
  end

  it "can click on the link" do
    link_control.should_receive(:click)
    screen.click_link_control
  end

  it "can dish out the view" do
    screen.link_control_view.should be(link_control)
  end

end
