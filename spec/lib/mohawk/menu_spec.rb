require 'spec_helper'

describe 'menus' do
  Given(:main_form) { start_app }

  context 'by text' do
    When { main_form.menu_item_by_text }
    Then { on(About).active? }
  end

  context 'by path' do
    When { main_form.menu_item_by_path }
    Then { on(About).active? }
  end

  context '#click_menu_item' do
    When { main_form.click_menu_item_by_path }
    Then { on(About).active? }
  end
end