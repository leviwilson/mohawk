class ScreenWithContainer
  include Mohawk
  window(:title => /MainForm/)
  parent(:id => 'numericUpDown')

  button(:up, :id => 'SmallIncrement')
  button(:down, :id => 'SmallDecrement')
end