require 'spec_helper'

describe 'radio buttons' do
  Given(:screen) do
    start_app
    on(Class.new do
      include Mohawk
      window title: /MainForm/

      radio(:radio_one, id: 'radioButton1')
      label(:status, id: 'radioButtonLabel')
    end)
  end

  Then { screen.radio_one_view.class == Mohawk::Adapters::UIA::Radio }

  context '#radio' do
    When { screen.radio_one }
    Then { screen.status == 'Option 1 selected' }
    And { screen.radio_one? == true }
  end
end