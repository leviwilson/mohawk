# Mohawk
[![Build Status](https://travis-ci.org/leviwilson/mohawk.png)](https://travis-ci.org/leviwilson/mohawk)

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
