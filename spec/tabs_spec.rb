require 'spec_helper'

describe 'tabs' do
  Given(:screen) { start_app.about; on(About) }

  Then { screen.tab == 'Info' }
  Then { screen.tab_items == ['Info', 'Other Info'] }
  Then { screen.tab_view.class == Mohawk::Adapters::UIA::TabControl }

  context '#select_tab' do
    context 'by index' do
      When { screen.tab = 1 }
      Then { screen.tab == 'Other Info' }
    end

    context 'by value' do
      When { screen.tab = 'Other Info' }
      When { screen.tab == 'Other Info' }
    end

    context 'by Regex' do
      When { screen.tab = /[Oo]th/ }
      Then { screen.tab == 'Other Info' }
    end
  end
end