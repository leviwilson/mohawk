require 'spec_helper'

describe Mohawk::Adapters::UIA::Window do
  Given(:main_form) { start_app }
  Given!(:not_created_form) { MainForm.new }
  Given(:about) { main_form.about; on(About) }

  context 'container' do
    Given(:container) do
      start_app
      on(Class.new do
        include Mohawk
        window(title: /MainForm/)
        parent(id: 'numericUpDown')
      end)
    end

    Then { container.adapter.window.title == 'linkLabel1' }
  end

  context 'children_only' do
    Given(:limit_scope) do
      start_app.data_grid_view
      on(Class.new do
        include Mohawk
        window(title: /DataGridViewForm/, children_only: true)

        button(:close, :value => 'Close')
      end)
    end

    When(:time_it_took) { Benchmark.measure { limit_scope.close } }
    Then { time_it_took.real < 2 }
  end

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

  context '#has_text?' do
    Then { expect(main_form).to have_text 'Assorted UI Elements' }
  end

  context '#wait_for_control' do
    Then { main_form.wait_for_control value: 'Data Entry Form' }
  end
end