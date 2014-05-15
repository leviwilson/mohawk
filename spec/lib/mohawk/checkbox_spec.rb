require 'spec_helper'

describe 'checkboxes' do
  Given(:main_screen) { start_app }

  Then { main_screen.checkbox_value == 'checkBox' }
  Then  { main_screen.checkbox_view.class == Mohawk::Adapters::UIA::CheckBox }

  context 'setting' do
    Given(:uncheck) { main_screen.checkbox = false }
    Given(:check) { main_screen.checkbox = true }

    context 'checking' do
      When { check }
      Then { main_screen.checkbox == true }
    end

    context 'un-checking' do
      When { check; uncheck }
      Then { main_screen.checkbox == false }
    end
  end
end