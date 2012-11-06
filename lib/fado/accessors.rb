module Fado
  module Accessors
    def window(locator)
      define_method("which_window") do
        locator
      end
    end
    
    def text(name, locator)
      define_method("#{name}") do 
        adapter.window.text_field(locator).value
      end
      define_method("#{name}=") do |text|
        adapter.window.text_field(locator).set text
      end
    end
  end
end
