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

  context 'waiting for' do
    Given { Mohawk.timeout = 2 }

    When(:non_existent_menu) { main_form.non_existent_menu }
    When(:click_non_existent_menu) { main_form.click_non_existent_menu }

    Then { expect(non_existent_menu).to have_failed(Mohawk::Waiter::WaitTimeout) }
    Then { expect(click_non_existent_menu).to have_failed(Mohawk::Waiter::WaitTimeout) }
  end
end