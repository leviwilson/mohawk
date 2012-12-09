module Mohawk
  module Accessors
    
    #
    # Defines the locator indicating the top-level window that will be used
    # to find controls in the page
    #
    # @example
    #   window(:title => /Title of Some Window/)
    #
    # @param  [Hash]  locator for the top-level window that hosts the page
    #
    def window(locator)
      define_method("which_window") do
        locator
      end
    end
    
    #
    # Generates methods to enter text into a text field, get its value
    # and clear the text field
    #
    # @example
    #   text(:first_name, :id => 'textFieldId')
    #   # will generate 'first_name', 'first_name=' and 'clear_first_name' methods
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the text is found
    #
    def text(name, locator)
      define_method("#{name}") do 
        adapter.text(locator).value
      end
      define_method("#{name}=") do |text|
        adapter.text(locator).set text
      end
      define_method("clear_#{name}") do
        adapter.text(locator).clear
      end
      define_method("enter_#{name}") do |text|
        adapter.text(locator).enter text
      end
    end
    
    #
    # Generates methods to click on a button as well as get the value of 
    # the button text
    #
    # @example
    #   button(:close, :value => '&Close')
    #   # will generate 'close' and 'close_value' methods
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the button is found
    #
    def button(name, locator)
      define_method("#{name}") do |&block|
        adapter.button(locator).click &block
      end
      define_method("#{name}_value") do
        adapter.button(locator).value
      end
    end

    #
    # Generates methods to get the value of a combo box, set the selected
    # item by both index and value as well as to see the available options
    #
    # @example
    #   combo_box(:status, :id => 'statusComboBox')
    #   # will generate 'status', 'status=' and 'status_options' methods
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the combo box is found
    #
    def combo_box(name, locator)
      define_method("#{name}") do
        adapter.combo(locator).value
      end
      define_method("#{name}=") do |item|
        adapter.combo(locator).set item
      end
      define_method("#{name}_options") do
        adapter.combo(locator).options
      end
    end

    #
    # Generates methods to get/set the value of a checkbox as well as
    # to get the text value of the control
    #
    # @example
    #   checkbox(:include, :id => 'checkBoxId')
    #   # will generate 'include', 'include=' and 'include_value' methods
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the checkbox is found
    #
    def checkbox(name, locator)
      define_method("#{name}") do
        adapter.checkbox(locator).checked?
      end
      define_method("#{name}=") do |should_check|
        adapter.checkbox(locator).set_check should_check
      end
      define_method("#{name}_value") do
        adapter.checkbox(locator).value
      end
    end

    #
    # Generates methods to set a radio button as well as see if one
    # is selected
    #
    # @example
    #   radio(:morning, :id => 'morningRadio')
    #   # will generate 'morning' and 'morning?' methods
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the radio is found
    #
    def radio(name, locator)
      define_method("#{name}") do
        adapter.radio(locator).set
      end
      define_method("#{name}?") do
        adapter.radio(locator).set?
      end
    end

    #
    # Generates methods to get the value of a label control
    #
    # @example
    #   label(:login_info, :id => 'loginInfoLabel')
    #   # will generate a 'login_info' method
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the label is found
    #
    def label(name, locator)
      define_method("#{name}") do
        adapter.label(locator).value
      end
    end

    # Generates methods to work with menu items
    #
    # @example
    #   menu_item(:some_menu_item, :path => ["Path", "To", "A", "Menu Item"])
    #   # will generate a 'some_menu_item' method to select a menu item
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the label is found
    #
    def menu_item(name, locator)
      define_method("#{name}") do
        adapter.menu_item(locator).select
      end
    end

    # Generates methods for working with table or list view controls
    #
    # @example
    #   table(:some_table, :id => "tableId")
    #   # will generate a 'some_table_rows' method to list each of the row items in a table
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the label is found
    #
    def table(name, locator)
      define_method("#{name}=") do |which_item|
        adapter.table(locator).select which_item
      end
      define_method("#{name}_rows") do
        adapter.table(locator).rows
      end
      define_method("#{name}_row") do |which_row|
        adapter.table(locator).row which_row
      end
    end

    def tree_view(name, locator)
      define_method("#{name}") do
        adapter.tree_view(locator).value
      end
      define_method("#{name}=") do |which_item|
        adapter.tree_view(locator).select which_item
      end
      define_method("#{name}_items") do
        adapter.tree_view(locator).items
      end
      define_method("expand_#{name}_item") do |which_item|
        adapter.tree_view(locator).expand which_item
      end
    end
  end
end
