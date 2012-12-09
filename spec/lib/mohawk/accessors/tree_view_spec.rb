require 'spec_helper'

class TreeViewScreen
  include Mohawk
  window(:id => nil)

  tree_view(:oak, :id => "treeViewId")
end

class FakeTreeItem
  attr_reader :text

  def initialize(item_text)
    @text = item_text
  end
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

  it "can return the tree items" do
    tree_field.should_receive(:options).and_return([FakeTreeItem.new("Item One"), FakeTreeItem.new("Item Two")])
    screen.oak_items.should eq ["Item One", "Item Two"]
  end

  it "can expand items by index" do
    tree_field.should_receive(:expand).with(7)
    screen.expand_oak_item 7
  end
end
