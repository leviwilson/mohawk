require 'spec_helper'

class TreeViewScreen
  include Mohawk
  window(:id => nil)

  tree_view(:oak, :id => "treeViewId")
end

describe Mohawk::Accessors::TreeView do
  let(:screen) { TreeViewScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:tree_field) { double("TreeView Field") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:select_list).with(:id => "treeViewId").and_return(tree_field)
  end

  it "has a value" do
    tree_field.should_receive(:value).and_return("tree value")
    screen.oak.should eq "tree value"
  end

  it "can select items by index" do
    tree_field.should_receive(:select).with(7)
    screen.oak = 7
  end

  it "can select items by their value" do
    tree_field.should_receive(:set).with("item value")
    screen.oak = "item value"
  end
end
