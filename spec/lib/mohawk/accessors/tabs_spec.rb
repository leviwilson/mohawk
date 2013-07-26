require 'spec_helper'

class TabsScreen
  include Mohawk
  window(:id => 123)

  tabs(:tab, :id => 'tabsId')
end

class TabItem
  attr_reader :text, :index
  def initialize(text, index)
    @text, @index = text, index
  end
end

describe Mohawk::Accessors::Tabs do
  let(:window) { double('RAutomation Window') }
  let(:tab_control) { double('RAutomation TabControl') }
  subject { TabsScreen.new }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:tab_control).with(:id => 'tabsId').and_return(tab_control)
  end

  it 'knows the currently selected tab' do
    tab_control.should_receive(:value).and_return('Current Tab')

    subject.tab.should eq('Current Tab')
  end

  it 'knows the available tabs' do
    tab_control.should_receive(:items).and_return([TabItem.new('first', 0), TabItem.new('second', 1)])

    subject.tab_items.should eq(['first', 'second'])
  end
end