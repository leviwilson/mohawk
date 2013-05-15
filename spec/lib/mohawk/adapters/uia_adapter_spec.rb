require 'spec_helper'

class AnyScreen
  include Mohawk
  window(:title => /Some Title/)
end

RSpec::Matchers.define(:use_the_cached) do |control_type, the_alias=nil|
  match do |screen|
    screen.adapter.window.stub(the_alias || control_type).and_return(double('first control'), double('second control'))
    first, second = 2.times.map { screen.adapter.send(control_type, :id => 'id') }
    first.eql?(second)
  end
end

describe Mohawk::Adapters::UiaAdapter do
  subject(:screen) { AnyScreen.new }

  let(:window) { double('RAutomation Window') }
  before(:each) { RAutomation::Window.stub(:new).and_return(window) }

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