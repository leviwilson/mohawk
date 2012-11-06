class MainScreen
  include Fado

  window(:title => /MainFormWindow/)

  text(:text_field_by_id, :id => "textField")
end
