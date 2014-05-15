require 'spec_helper'

describe Mohawk::Adapters::UIA::Window do
  Given(:main_form) { start_app }
  Given(:about) { main_form.about; on(About) }

  context '#present' do
    Then { about.present? == true }

    context 'closing / opening' do
      When { about.close }
      Then { about.present? == false }
    end
  end
end