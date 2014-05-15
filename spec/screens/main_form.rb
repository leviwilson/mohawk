class MainForm
  include Mohawk
  window title: /MainForm/

  button(:about, id: 'aboutButton')
  button(:data_entry_form, value: 'Data Entry Form')
end