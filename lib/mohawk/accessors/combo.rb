module Mohawk
  module Accessors
    class Combo
      attr_reader :view

      def initialize(adapter, locator)
        @view = adapter.window.select_list(locator)
      end

      def set(value)
        @view.options[value].select if value.instance_of? Fixnum
        @view.option(text: value).select if value.instance_of? String
      end

      def method_missing(meth, *args, &block)
        @view.send(meth, *args, &block)
      end

      def options
        @view.options.map &:text
      end
    end
  end
end
