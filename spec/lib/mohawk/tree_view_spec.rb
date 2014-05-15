require 'spec_helper'

describe 'tree views' do
  Given(:main_screen) { start_app }

  Then { main_screen.tree_view_view.class == Mohawk::Adapters::UIA::TreeView }

  context '#tree_view=' do
    context 'by index' do
      When { main_screen.tree_view = 1 }
      Then { main_screen.tree_view == 'Parent Two' }
    end

    context 'by value' do
      When { main_screen.tree_view = 'Parent Two' }
      Then { main_screen.tree_view == 'Parent Two' }
    end
  end

  context '#tree_view_items' do
    Then { main_screen.tree_view_items == ['Parent One', 'Parent Two'] }
  end

  context '#expand/collapse_tree_view' do
    Given(:original_items) { ['Parent One', 'Parent Two'] }
    Given(:expected_items) { ['Parent One', 'Child 1', 'Child 2', 'Parent Two'] }

    context 'by index' do
      When { main_screen.expand_tree_view_item 0 }

      context 'expand' do
        Then { main_screen.tree_view_items ==  expected_items}
      end

      context 'collapse' do
        When { main_screen.collapse_tree_view_item 0 }
        Then { main_screen.tree_view_items == original_items }
      end
    end

    context 'by value' do
      When { main_screen.expand_tree_view_item 'Parent One' }

      context 'expand' do
        Then { main_screen.tree_view_items ==  expected_items}
      end

      context 'collapse' do
        When { main_screen.collapse_tree_view_item 'Parent One' }
        Then { main_screen.tree_view_items ==  original_items}
      end
    end
  end
end