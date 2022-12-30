require 'spec_helper'

describe 'combo boxes' do
  Given(:main_form) { start_app }

  context '#combo_box= / #combo_box' do
    context 'by index' do
      When { main_form.fruits = 2 }
      Then { main_form.fruits == 'Coconut' }
    end

    context 'by value' do
      When { main_form.fruits = 'Coconut' }
      Then { main_form.fruits == 'Coconut' }
    end

    context 'by Regex' do
      When { main_form.fruits = /[Or]an/ }
      Then { main_form.fruits == 'Orange' }
    end

    context '#options' do
      Then { main_form.fruits_options == ["Apple", "Caimito", "Coconut", "Orange", "Passion Fruit"] }
    end
  end

  describe 'list boxes' do
    Given(:main_form) { start_app }

    context 'multi-select' do
      Given { main_form.toggle_multi }
      When { (0..2).each {|n| main_form.select_fruits_list n } }

      Then { main_form.fruits_list_selections == ['Apple', 'Orange', 'Mango'] }

      context '#clear_' do
        context 'by index' do
          When { main_form.clear_fruits_list 2 }
          Then { main_form.fruits_list_selections == ['Apple', 'Orange'] }
        end

        context 'by value' do
          When { main_form.clear_fruits_list 'Orange' }
          Then { main_form.fruits_list_selections == ['Apple', 'Mango'] }
        end

        context 'by Regex' do
          When { main_form.clear_fruits_list /p{2}/ }
          Then { main_form.fruits_list_selections == ['Orange', 'Mango'] }
        end
      end
    end

    context 'events' do
      # ListBox controls are special with regard to raising events
      When { main_form.fruits_list = 'Orange' }
      Then { main_form.fruits_label == 'Orange' }
    end
  end
end
