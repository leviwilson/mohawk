require 'spec_helper'

describe 'buttons' do
  Given(:main_form) { start_app }

  context 'pressing' do
    When { main_form.data_entry_form }
    Then { expect(on(DataEntryForm)).to be_present }
  end

  context '#value' do
    Then { main_form.data_entry_form_value == 'Data Entry Form' }
  end
end