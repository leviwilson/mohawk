require 'spec_helper'

class TreeViewScreen
  include Mohawk
  window(:id => nil)

  tree_view(:oak, :id => "treeViewId")

  # aliases
  tree_view(:my_default, :id => "defaultAliasId")
  treeview(:my_treeview, :id => "treeviewAliasId")
  tree(:my_tree, :id => "treeAliasId")
end

class FakeTreeItem
  attr_reader :text

  def initialize(item_text)
    @text = item_text
  end
end

describe Mohawk::Adapters::RAuto::TreeView do
  let(:screen) { TreeViewScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:tree_field) { double("TreeView Field") }
  let(:options) { double("TreeView Options") }
  let(:option) { double("TreeView Option") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    tree_field.stub(:options).and_return(options)
  end

  context "working with TreeView controls" do
    before(:each) do
      window.should_receive(:select_list).with(:id => "treeViewId").and_return(tree_field)
    end

    it "has a value" do
      tree_field.should_receive(:value).and_return("tree value")
      screen.oak.should eq "tree value"
    end

    it "can select items by index" do
      options.should_receive(:[]).with(7).and_return(option)
      option.should_receive(:select)

      screen.oak = 7
    end

    it "can select items by their value" do
      tree_field.should_receive(:option).with(text: 'item value').and_return(option)
      option.should_receive(:select)

      screen.oak = "item value"
    end

    it "can return the tree items" do
      tree_field.should_receive(:options).and_return([FakeTreeItem.new("Item One"), FakeTreeItem.new("Item Two")])
      screen.oak_items.should eq ["Item One", "Item Two"]
    end

    it "can expand items" do
      tree_field.should_receive(:expand).with(7)
      screen.expand_oak_item 7
    end

    it "can collapse items" do
      tree_field.should_receive(:collapse).with("some item")
      screen.collapse_oak_item "some item"
    end

    it "can work with the raw view" do
      tree_field.should_receive(:visible?).and_return(true)
      screen.oak_view.should be_visible
    end
  end

  context "aliases for tree_view" do
    let(:null_tree_view) { double("Null TreeView Field").as_null_object }
    let(:tree_view_aliases) { ["default", "treeview", "tree"] }

    def expected_alias(id)
      window.should_receive(:select_list).with(:id => "#{id}AliasId").ordered.and_return(null_tree_view)
    end

    it "has many aliases" do
      tree_view_aliases.each do |which_alias|
        expected_alias which_alias
      end

      tree_view_aliases.each do |which_alias|
        screen.send "my_#{which_alias}"
      end
    end
  end
end
