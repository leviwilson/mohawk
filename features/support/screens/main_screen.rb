class MainScreen
  include Mohawk
  window(:title => /MainFormWindow/)

  text(:text_field, :id => "textField")
  text(:masked_text_field, :id => "maskedTextBox")
  button(:data_entry_form_button, :value => "Data Entry Form")
  combo_box(:fruits, :id => "FruitsComboBox")
  checkbox(:first_checkbox, :id =>  "checkBox")
  radio(:first_radio, :id => "radioButton1")
  label(:label_control, :id => "label1")
  menu_item(:file_roundabout_way_to_about, :path => ["File", "Roundabout Way", "To", "About"])
end
