require 'spec_helper'

describe 'controls' do
  Given(:main_screen) { start_app }

  Then { main_screen.month_calendar_view.class == Mohawk::Adapters::UIA::ValueControl }

  context '#control=' do
    When { main_screen.month_calendar = '9/28/1979' }
    Then { main_screen.month_calendar_value == '9/28/1979 12:00:00 AM' }
  end

  context '#click_' do
    When { main_screen.click_about_control }
    Then { on(About) != nil }
  end
end