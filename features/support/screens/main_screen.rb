class MainScreen
  include Fado
  window(:title => /MainFormWindow/)

  text(:text_field, :id => "textField")
  button(:data_entry_form_button, :value => "Data Entry Form")
  combo_box(:fruits, :id => "FruitsComboBox")
  checkbox(:first_checkbox, :id =>  "checkBox")
end
