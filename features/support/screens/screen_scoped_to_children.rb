class ScreenScopedToChildren
  include Mohawk
  window(:title => /DataGridViewForm/, :children_only => true)

  button(:close, :value => 'Close')
end