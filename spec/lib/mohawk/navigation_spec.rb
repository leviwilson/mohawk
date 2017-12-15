require 'spec_helper'

class NonExistentScreen
  include Mohawk
  window(:title => /I don't exist/)
end

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

  context 'name the screen that could not be found' do
    When { Mohawk.timeout = 1 }
    Then do
      screen_class = NonExistentScreen
      expect { on(screen_class) }.to raise_error Mohawk::Waiter::WaitTimeout, "Unable to locate '#{screen_class}'"
    end
  end
end
