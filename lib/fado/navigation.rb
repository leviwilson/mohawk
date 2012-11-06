module Fado
  module Navigation
    def on(cls, &block)
      @screen = cls.new
      block.call @screen if block
      @screen
    end
  end
end
