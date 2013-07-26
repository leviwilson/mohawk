class AboutScreen
  include Mohawk
  window(:title => /About/)

  button(:close, :value => "OK")
  tabs(:tab, :id => 'tabControl1')
end

