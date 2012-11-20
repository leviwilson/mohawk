module Mohawk
  module Navigation
    def on(cls, &block)
      @screen = cls.new
      RAutomation::WaitHelper.wait_until { @screen.present? }
      block.call @screen if block
      @screen
    end
  end
end
