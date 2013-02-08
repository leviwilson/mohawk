require 'page_navigation'

module Mohawk
  module Navigation
    include PageNavigation

    def on(cls, extra={}, &block)
      screen = cls.new extra
      screen.wait_until_present
      block.call screen if block
      screen
    end
  end
end
