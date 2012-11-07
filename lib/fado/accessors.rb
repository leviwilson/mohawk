module Fado
  module Accessors
    def window(locator)
      define_method("which_window") do
        locator
      end
    end
    
    def text(name, locator)
      define_method("#{name}") do 
        adapter.get_text(locator)
      end
      define_method("#{name}=") do |text|
        adapter.set_text(text, locator)
      end
      define_method("clear_#{name}") do
        adapter.clear_text(locator)
      end
    end

    def button(name, locator)
      define_method("#{name}") do |&block|
        adapter.click_button(locator, &block)
      end
      define_method("#{name}_value") do
        adapter.get_button_value(locator)
      end
    end
  end
end
