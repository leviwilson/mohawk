require 'spec_helper'

class NavigationTestScreen
end

include Mohawk::Navigation

describe Mohawk::Navigation do
  before(:each) do
    NavigationTestScreen.stub(:new).and_return(screen)
  end

  Given(:screen) { double('Mohawk Screen').as_null_object }

  Then { on(NavigationTestScreen) == screen }

  context 'blocks' do
    When { on(NavigationTestScreen) {|s| s.expected_method } }
    Then { expect(screen).to have_received(:expected_method) }
  end

  context 'waiting until it exists' do
    When { on(NavigationTestScreen).was_used }
    Then { expect(screen).to have_received :wait_until_present }
    And { expect(screen).to have_received :was_used }
  end

  context 'additional information' do
    Given { expect(NavigationTestScreen).to receive(:new).with(extra: :info).and_return(screen) }
    When(:result) { on(NavigationTestScreen, extra: :info) }
    Then { result == screen }
  end
end
