require 'spec_helper'

class AnyScreen
  include Mohawk
  window(:title => /Some Title/, :children_only => true)
end

RSpec::Matchers.define(:use_the_cached) do |control_type, the_alias=nil|
  match do |screen|
    screen.adapter.window.stub(the_alias || control_type).and_return(double('first control'), double('second control'))
    first, second = 2.times.map { screen.adapter.send(control_type, :id => 'id') }
    first.eql?(second)
  end
end

RSpec::Matchers.define(:only_search_children_for_a) do |control_type, the_alias=nil|
  match do |screen|
    screen.adapter.window.should_receive(the_alias || control_type).with(:id => 'id', :children_only => true).and_return(double('child control'))
    screen.adapter.send(control_type, :id => 'id')
    true
  end
end

describe Mohawk::Adapters::RAutomationAdapter do
  subject(:screen) { AnyScreen.new }

  let(:window) { double('RAutomation Window') }
  before(:each) { RAutomation::Window.stub(:new).and_return(window) }

  context 'limiting searches to children only' do
    it { should only_search_children_for_a(:combo, :select_list) }
    it { should only_search_children_for_a(:checkbox) }
    it { should only_search_children_for_a(:text, :text_field) }
    it { should only_search_children_for_a(:button) }
    it { should only_search_children_for_a(:radio) }
    it { should only_search_children_for_a(:label) }
    it { should only_search_children_for_a(:link, :label) }
    it { should only_search_children_for_a(:table) }
    it { should only_search_children_for_a(:tree_view, :select_list) }
    it { should only_search_children_for_a(:value_control) }
  end

  context 'caching controls' do
    it { should use_the_cached(:combo, :select_list) }
    it { should use_the_cached(:checkbox) }
    it { should use_the_cached(:text, :text_field) }
    it { should use_the_cached(:button) }
    it { should use_the_cached(:radio) }
    it { should use_the_cached(:label) }
    it { should use_the_cached(:link, :label) }
    it { should use_the_cached(:table) }
    it { should use_the_cached(:tree_view, :select_list) }
    it { should use_the_cached(:value_control) }
  end
end