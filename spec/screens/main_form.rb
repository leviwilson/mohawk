class MainForm
  include Mohawk
  window title: /MainForm/

  text(:text_field, id: 'textField')
  text(:masked_text_field, :id => 'maskedTextBox')
  text(:multiline_text_field, id: 'multiLineTextField')

  button(:about, id: 'aboutButton')
  button(:data_entry_form, value: 'Data Entry Form')

  checkbox(:checkbox, id: 'checkBox')

  tree_view(:tree_view, id: 'treeView')

  label(:sample_label, id: 'label1')
  link(:link_label, id: 'linkLabel1')

  control(:month_calendar, id: 'automatableMonthCalendar1')
  control(:about_control, id: 'aboutButton')
end