class DataEntryForm
  include Mohawk
  window(:title => /DataEntry/)

  table(:people, :id => "personListView")
end
