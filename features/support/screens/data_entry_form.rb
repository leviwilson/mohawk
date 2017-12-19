class DataEntryForm
  include Mohawk
  window(:title => /DataEntry/)

  table(:people, :id => "personListView")
  button(:add_more, :value => 'Add Many')

  def wait_until_present(context=nil)
    super
    wait_for_control :id => "personListView"
  end
end
