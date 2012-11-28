require 'spec_helper'

class MenuItemScreen
  include Mohawk
  window(:id => nil)
  
  menu_item(:the_menu_item, :path => ["Path", "To", "Some Menu", "Item"])
end

describe Mohawk::Accessors::MenuItem do
  let(:screen) { MenuItemScreen.new }
  let(:window) { double("RAutomation Window") }
  let(:menu) { double("RAutomation Menu Item") }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
  end

  context "selecting menu items" do
    before(:each) do
      window.should_receive(:menu).with(:text => "Path").and_return(menu)
    end

    it "can open a menu item" do
      menu.should_receive(:menu).with(:text => "To").and_return(menu)
      menu.should_receive(:menu).with(:text => "Some Menu").and_return(menu)
      menu.should_receive(:menu).with(:text => "Item").and_return(menu)
      menu.should_receive(:open)
      screen.the_menu_item
    end
  end
end
