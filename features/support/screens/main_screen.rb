class MainScreen
  include Mohawk
  window(:title => /MainFormWindow/)

  text(:text_field, :id => "textField")
  button(:data_entry_form_button, :value => "Data Entry Form")
  combo_box(:fruits, :id => "FruitsComboBox")
  checkbox(:first_checkbox, :id =>  "checkBox")
  radio(:first_radio, :id => "radioButton1")
  label(:label_control, :id => "label1")
end
