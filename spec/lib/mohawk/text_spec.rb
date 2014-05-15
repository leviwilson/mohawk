require 'spec_helper'

describe 'text controls' do
  Given(:main_form) { start_app }

  Then { main_form.text_field_view.class == Mohawk::Adapters::UIA::TextBox }

  context '#text= / #text' do
    context 'edit controls' do
      When { main_form.text_field = 'text we set it to' }
      Then { main_form.text_field == 'text we set it to' }
    end

    context 'multi-line text fields' do
      When { main_form.multiline_text_field = 'multi-line text we set it to' }
      Then { main_form.multiline_text_field == 'multi-line text we set it to' }
    end
  end

  context '#clear_text' do
    context 'edit controls' do
      Given { main_form.text_field = 'text to be cleared' }
      When { main_form.clear_text_field }
      Then { main_form.text_field == '' }
    end

    context 'multi-line text fields' do
      Given { main_form.multiline_text_field = 'multiline text to be cleared' }
      When { main_form.clear_multiline_text_field }
      Then { main_form.multiline_text_field == '' }
    end
  end

  context '#enter_text' do
    context 'masked edit controls' do
      When { main_form.enter_masked_text_field 'abc12345willnotgoin6789' }
      Then { main_form.masked_text_field == '123-45-6789' }
    end
  end
end