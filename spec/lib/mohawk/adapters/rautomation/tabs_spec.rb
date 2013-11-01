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

describe Mohawk::Adapters::RAuto::Tabs do
  let(:window) { double('RAutomation Window') }
  let(:tab_control) { double('RAutomation TabControl') }
  subject { TabsScreen.new }

  before(:each) do
    RAutomation::Window.stub(:new).and_return(window)
    window.should_receive(:tab_control).with(:id => 'tabsId').and_return(tab_control)
  end

  def tabs_are(*tabs)
    expected = tabs.each_with_index.map {|t, i| TabItem.new(t, i) }
    tab_control.should_receive(:items).and_return(expected)
  end

  it 'knows the currently selected tab' do
    tab_control.should_receive(:value).and_return('Current Tab')

    subject.tab.should eq('Current Tab')
  end

  it 'knows the available tabs' do
    tabs_are('first', 'second')
    subject.tab_items.should eq(['first', 'second'])
  end

  it 'can select tabs by index' do
    tab_control.should_receive(:select).with(1)
    subject.tab = 1
  end

  it 'can select tabs by value' do
    tab_control.should_receive(:set).with('The Tab')
    subject.tab = 'The Tab'
  end

  it 'can select tabs by regex' do
    tabs_are('Something', 'With the Number 7')
    tab_control.should_receive(:set).with('With the Number 7')
    subject.tab = /\d+/
  end
end