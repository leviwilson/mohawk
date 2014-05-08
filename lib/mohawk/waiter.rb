module Mohawk
  module Waiter
    class WaitTimeout < StandardError;
    end

    def wait_until(timeout=60, &block)
      start = Time.now
      until (result = block.call) || (Time.now - start > timeout)
        sleep 0.25
      end

      raise WaitTimeout unless result
      result
    end
  end
end