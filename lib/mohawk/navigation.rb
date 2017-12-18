require 'page_navigation'

module Mohawk
  module Navigation
    include PageNavigation

    def on(cls, extra = {}, &block)
      screen = cls.new extra
      screen.wait_until_present
      block.call screen if block
      screen
    rescue Mohawk::Waiter::WaitTimeout => e
      raise e.class, e.message.sub(/window/, cls.to_s), e.backtrace
    end
  end
end
