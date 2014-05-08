require 'spec_helper'

class WaiterStub
  include Mohawk::Waiter
end

describe Mohawk::Waiter do
  Given(:waiter) do
    allow_any_instance_of(WaiterStub).to receive(:sleep) {}
    WaiterStub.new
  end

  def fake_time(*times)
    expect(Time).to receive(:now).exactly(times.count).times.and_return(*times)
  end

  def do_it
    @fake_responses.shift
  end

  context 'default timeout' do
    When { fake_time 0, 30, 60.1 }
    Then { expect { waiter.wait_until { false } }.to raise_error Mohawk::WaitTimeout }
  end

  context 'specific timeout' do
    When { fake_time 0, 30, 30.1 }
    Then { expect { waiter.wait_until(30) { false } }.to raise_error Mohawk::WaitTimeout }
  end

  context 'waits in between' do
    When do
      @fake_responses = [false,  true]
      fake_time 0, 1
    end

    Then { expect { waiter.wait_until { do_it } }.not_to raise_error }
  end
end