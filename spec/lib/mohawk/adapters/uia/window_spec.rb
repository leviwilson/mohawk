require 'spec_helper'

describe Mohawk::Adapters::UIA::Window do
  Given(:main_form) { start_app }
  Given!(:not_created_form) { MainForm.new }
  Given(:about) { main_form.about; on(About) }

  context '#active?' do
    Then { not_created_form.active? == false }
    Then { main_form.active? == true }

    context 'inactive --> active' do
      Given { about }
      When { about.close; Mohawk::Waiter.wait_until { !about.present? } }
      Then { not_created_form.active? == true }
    end

    context 'active --> inactive' do
      Given { expect(main_form).to be_active }
      When { about }
      Then { main_form.active? == false }
    end
  end

  context '#present?' do
    Then { about.present? == true }

    context 'closing / opening' do
      When { about.close }
      Then { about.present? == false }
    end
  end

  context '#exist?' do
    Then { not_created_form.exist? == false }

    context 'not there --> there' do
      When { start_app }
      Then { not_created_form.exist? == true }
    end

    context 'there --> not there' do
      Given { main_form }
      When { main_form.close }
      Then { main_form.exist? == false }
    end
  end
end