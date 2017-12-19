module Mohawk
  module Waiter
    extend self

    class WaitTimeout < StandardError;
    end

    def wait_until(timeout=Mohawk.timeout, context=nil, &block)
      start = Time.now
      until (result = block.call) || (Time.now - start > timeout)
        sleep 0.25
      end

      raise WaitTimeout, context unless result
      result
    end
  end
end
