require 'spec_helper'

describe 'spinners' do
  Given(:screen) do
    start_app
    on(Class.new do
      include Mohawk
      window(title: /MainForm/)

      spinner(:spinner, id: 'numericUpDown1')
    end)
  end

  Then { screen.spinner_view.class == Mohawk::Adapters::UIA::Spinner }

  context '#spinner=' do
    When { screen.spinner = 50.8 }
    Then { screen.spinner == 50.8 }
  end

  context '#increment_spinner' do
    When { 5.times { screen.increment_spinner} }
    Then { screen.spinner == 5.0 }
  end

  context '#decrement_spinner' do
    Given { screen.spinner = 10.0 }
    When { 3.times { screen.decrement_spinner } }
    Then { screen.spinner == 7.0 }
  end
end