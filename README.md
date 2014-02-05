# Mohawk
[![Build Status](https://travis-ci.org/leviwilson/mohawk.png)](https://travis-ci.org/leviwilson/mohawk)
[![Coverage Status](https://coveralls.io/repos/leviwilson/mohawk/badge.png?branch=master)](https://coveralls.io/r/leviwilson/mohawk?branch=master)

A gem to assist in building page-object like structures for testing Windows applications.

## Installation

### Runtime Environment
In order for `mohawk` to work, you need to have the [.NET 4.0 Framework](http://www.microsoft.com/en-us/download/details.aspx?id=24872) as well as the [C++ Runtime Redistributable](http://www.microsoft.com/en-us/download/details.aspx?id=5555).

### Ruby Environment
Add this line to your application's Gemfile:

    gem 'mohawk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mohawk

## Example

### Defining a screen

```ruby
require 'mohawk'

class LoginScreen
  include Mohawk
  window(:title => /Login/)

  text(:username, :id => "UserNameField")
  text(:password, :id => "PasswordField")
  
  button(:login, :value => "Login")
end
```

### Using the Page-Object
```ruby
World(Mohawk::Navigation)

on(LoginScreen) do |screen|
  screen.username = "levi"
  screen.password = "secret"
  screen.login
end
```

## Accessors
### Window
#### window
The `window` accessor defines how to locate the top-level window that you would like to use for your screen. Valid locators are dictated by the [RAutomation::Window](https://github.com/jarmo/RAutomation/blob/master/lib/rautomation/adapter/ms_uia/window.rb) class.

#### parent
There are times where you need to define the root parent window for your screen, but it happens to be within a child window of a top-level window. The `parent` accessor allows you to specify further within `window`, and that will be used as the root of all other searches.

### Controls
Control accessors are used to define various controls within your page object. Valid locators are dictated by the [RAutomation::Control](https://github.com/jarmo/RAutomation/blob/master/lib/rautomation/adapter/ms_uia/control.rb) class.

#### text
The `text` accessor is used to define an edit text control within your screen. Given `text(:user_name, id: 'txtUserName')`, you will get the following methods:

*  `:user_name` - gets the value
*  `:user_name=` - sets the value
*  `:clear_user_name` - clears the value
*  `:enter_user_name` - types the given value (useful for masked text fields)
*  `:user_name_view` - the raw RAutomation view

#### button
The `button` accessor is used to define a button control within your screen. Given `button(:ok, value: 'OK')`, you will get the following methods:

*  `:ok` - clicks the button
*  `:ok_value` - returns the text value of the button
*  `:ok_view` - the raw RAutomation view

#### combo_box
##### aliases
*  `:combobox`
*  `:dropdown` / `:drop_down`
*  `:select_list`

The `combo_box` accessor is used to define a control that implements the `SelectList` pattern, such as a `ComboBox`, `ListBox`, etc. Given `combo_box(:city, id: 'cbCities')`, you will get the following methods:

*  `:city` - returns the currently selected item
*  `:clear_city` - clears the item by either index, value or `RegEx`
*  `:city_selections` - returns the currently selected options
*  `:city=` / `:select_city` - sets the selected item by index, value or `RegEx`
*  `:city_options` - returns the list of available options
*  `:city_view` - the raw RAutomation view

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
