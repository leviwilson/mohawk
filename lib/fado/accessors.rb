module Fado
  module Accessors
    def window(locator)
      define_method("which_window") do
        locator
      end
    end
    
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
    end

    def button(name, locator)
      define_method("#{name}") do |&block|
        adapter.button(locator).click &block
      end
      define_method("#{name}_value") do
        adapter.button(locator).value
      end
    end

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

    def radio(name, locator)
      define_method("#{name}") do
        adapter.set_radio(locator)
      end
      define_method("#{name}?") do
        adapter.radio_is_set? locator
      end
    end
  end
end
