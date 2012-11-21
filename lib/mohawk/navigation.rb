module Mohawk
  module Navigation
    def on(cls, &block)
      screen = cls.new
      screen.wait_until_present
      block.call screen if block
      screen
    end
  end
end
