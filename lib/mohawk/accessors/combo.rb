module Mohawk
  module Accessors
    class Combo
      attr_reader :view

      def initialize(adapter, locator)
        @view = adapter.window.select_list(locator)
      end

      def set(value)
        find(value).select
      end

      def clear(value)
        find(value).clear
      end

      def method_missing(meth, *args, &block)
        return super unless @view.respond_to?(meth)
        @view.send(meth, *args, &block)
      end

      def options
        @view.options.map &:text
      end

      def find(what)
        case what
          when Fixnum
            @view.options[what]
          when String
            @view.option(text: what)
        end
      end
    end
  end
end
