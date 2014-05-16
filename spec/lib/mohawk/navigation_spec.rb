require 'spec_helper'

describe Mohawk::Navigation do
  context '#on with extra info' do
    When { start_app }
    Then { on(MainForm, pid: Mohawk.app.pid).present? }
  end

  context '#navigate_to' do
    Given do
      Mohawk::Navigation.routes = {
          :default => [
              [MainForm, :about],
              [About, :close],
              [MainForm, :data_entry_form],
              [DataEntryForm]
          ]
      }
      start_app
    end

    When(:data_entry_form) { navigate_to(DataEntryForm) }
    Then { expect(data_entry_form).to be_present }
  end
end