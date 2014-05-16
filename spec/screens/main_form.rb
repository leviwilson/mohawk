class MainForm
  include Mohawk
  window title: /MainForm/

  text(:text_field, id: 'textField')
  text(:masked_text_field, :id => 'maskedTextBox')
  text(:multiline_text_field, id: 'multiLineTextField')

  button(:close, id: 'Close')
  button(:about, id: 'aboutButton')
  button(:data_entry_form, value: 'Data Entry Form')
  button(:data_grid_view, value: 'Data Grid View')
  button(:toggle_multi, value: 'Toggle Multi-Select')

  checkbox(:checkbox, id: 'checkBox')

  combo_box(:fruits, id: 'FruitsComboBox')
  select_list(:fruits_list, id: 'FruitListBox')

  tree_view(:tree_view, id: 'treeView')

  label(:sample_label, id: 'label1')
  label(:fruits_label, :id => 'fruitsLabel')

  link(:link_label, id: 'linkLabel1')

  menu_item(:menu_item_by_path, path: ['File', 'Roundabout Way', 'To', 'About'])
  menu_item(:menu_item_by_text, text: 'About')

  control(:month_calendar, id: 'automatableMonthCalendar1')
  control(:about_control, id: 'aboutButton')
end