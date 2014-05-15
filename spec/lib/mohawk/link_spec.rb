require 'spec_helper'

describe 'links' do
  Given(:main_form) { start_app }

  Then { main_form.link_label_view.class == Mohawk::Adapters::UIA::Control }

  context '#link_text' do
    Then { main_form.link_label_text == 'linkLabel1' }
  end

  context '#click_link' do
    When { main_form.click_link_label }
    Then { main_form.link_label_text == 'linkLabel1 (clicked 1 times)' }
  end
end