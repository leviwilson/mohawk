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
      define_method("#{name}_view") do
        adapter.text(locator).view
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
      define_method("#{name}_view") do
        adapter.button(locator).view
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
    # === Aliases
    # * combobox
    # * dropdown / drop_down
    # * select_list
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
      define_method("#{name}_view") do
        adapter.combo(locator).view
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
      define_method("#{name}_view") do
        adapter.checkbox(locator).view
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
      define_method("#{name}_view") do
        adapter.radio(locator).view
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
      define_method("#{name}_view") do
        adapter.label(locator).view
      end
    end

    #
    # Generates methods to work with link controls
    #
    # @example
    #   link(:send_info_link, :id => 'sendInfoId')
    #   # will generate 'send_info_link_text' and 'click_send_info_link' methods
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the label is found
    #
    def link(name, locator)
      define_method("#{name}_text") do
        adapter.link(locator).value
      end
      define_method("click_#{name}") do
        adapter.link(locator).click
      end
      define_method("#{name}_view") do
        adapter.link(locator).view
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
    #   # will generate 'some_table=', 'some_table_rows' and 'some_table_row(item)' methods to
    #   # select a table item, return all of the rows as well as return an individual row
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the label is found
    #
    # === Aliases
    # * listview
    # * list_view
    #
    def table(name, locator)
      define_method("#{name}") do
        adapter.table(locator)
      end
      define_method("#{name}=") do |which_item|
        adapter.table(locator).select which_item
      end
      define_method("#{name}_headers") do
        adapter.table(locator).headers
      end
      define_method("#{name}_view") do
        adapter.table(locator).view
      end
    end

    # Generates methods for working with tree view controls
    #
    # @example
    #   tree_view(:tree, :id => "treeId")
    #   # will generate 'tree', 'tree=', 'tree_items', 'expand_tree_item' and 'collapse_tree_item'
    #   # methods to get the tree value, set the tree value (index or string), get all of the 
    #   # items, expand an item (index or string) and collapse an item (index or string)
    #
    # @param  [String]  the name used for the generated methods
    # @param  [Hash]  locator for how the label is found
    #
    # === Aliases
    # * treeview
    # * tree
    #
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
      define_method("collapse_#{name}_item") do |which_item|
        adapter.tree_view(locator).collapse which_item
      end
    end

    # combo_box aliases
    alias_method :combobox, :combo_box
    alias_method :dropdown, :combo_box
    alias_method :drop_down, :combo_box
    alias_method :select_list, :combo_box

    # table aliases
    alias_method :listview, :table
    alias_method :list_view, :table

    # tree_view aliases
    alias_method :treeview, :tree_view
    alias_method :tree, :tree_view

  end
end
