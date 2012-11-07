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
      define_method("clear_#{name}") do
        adapter.window.text_field(locator).clear
      end
    end

    def button(name, locator)
      define_method("#{name}") do |&block|
        adapter.window.button(locator).click &block if block
        adapter.window.button(locator).click {true } unless block
      end
    end
  end
end
