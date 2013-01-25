class DataEntryForm
  include Mohawk
  window(:title => /DataEntry/)

  table(:people, :id => "personListView")

  def wait_until_present
    super
    wait_for_control :id => "personListView"
  end
end
