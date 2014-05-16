class About
  include Mohawk
  window title: 'About'

  button(:close, id: 'Close')
  tabs(:tab, id: 'tabControl1')
end