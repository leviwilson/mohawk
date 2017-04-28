require 'spec_helper'

class TestScreen
  include Mohawk
  window(:title => "Some Window Title")
  
  text(:text_id, :id => "textId")
end

describe Mohawk do
  let(:screen) { TestScreen.new }
  let(:window) { double 'window' }

  before(:each) do
    Mohawk.app_path = nil
    Mohawk.instance_variable_set(:@app, nil)
  end

  def expected_window(*args)
    w = double 'window'
    expect(Mohawk::Adapters::UIA::Window).to receive(:new).with(*args).and_return w
    w
  end

  context 'default adapter' do
    Then { TestScreen.new.adapter.class ==  Mohawk::Adapters::UiaAdapter  }
  end

  context 'additional locator information' do
    Then do
      expect(Mohawk.default_adapter).to receive(:new).with title: 'Some Window Title', extra: 'test'
      TestScreen.new extra: 'test'
    end
  end

  context '#default_timeout' do
    Given!(:default_timeout) { Mohawk.timeout }

    Then { default_timeout == 60 }

    When { Mohawk.timeout = 123 }
    Then { Mohawk.timeout == 123 }
  end

  context 'launching an application' do
    let(:process) { double 'child process', pid: 123 }

    before(:each) do
      allow(Uia).to receive(:find_element).and_return double
      allow(process).to receive(:start).and_return(process)
      [:exited?, :stop].each { |x| allow(process).to receive(x) }
      allow(ChildProcess).to receive(:build).with('./the/app/path.exe').and_return(process)

      allow(window).to receive(:present?).and_return(true)

      Mohawk.app_path = './the/app/path.exe'
    end

    context 'requires app_path' do
      When { Mohawk.app_path = nil }
      Then { expect { Mohawk.start }.to raise_error(Mohawk::InvalidApplicationPath, 'You must set the Mohawk.app_path to start an application') }
    end

    context 'starting' do
      context 'fast starters' do
        Given { expect(Uia).to receive(:find_element).and_return double }
        Then do
          expect(process).to receive(:start)
          Mohawk.start
        end
      end

      context 'slow starters' do
        Then { process.pid == 123}
        Then do
          expect(Uia).to receive(:find_element).with(pid: 123).and_return(nil, nil, double)
          Mohawk.start
        end
      end
    end

    context 'stopping' do
      context '#stop' do
        Given { Mohawk.start }
        When { Mohawk.stop }
        Then { expect(process).to have_received(:stop) }
      end

      context 'never started' do
        Then { expect { Mohawk.stop }.to raise_error 'An application was never started'}
      end

      context 'already stopped' do
        Given { expect(process).to receive(:exited?).and_return true }
        When { Mohawk.start; Mohawk.stop }
        Then { expect(process).not_to have_received :stop }
      end

      context 'cleans up state' do
        When { Mohawk.start; Mohawk.stop }
        Then { Mohawk.app == nil }
      end
    end
  end

  context '#required_controls' do
    Given { start_app; Mohawk.timeout = 1 }
    Given(:has_controls) do
      Class.new do
        include Mohawk
        window title: /MainForm/
        required_controls :about, :data_grid_view
        button(:about, value: 'About')
        button(:data_grid_view, value: 'Data Grid View')
      end
    end
    Given(:missing_controls) do
      Class.new do
        include Mohawk
        window title: /MainForm/
        required_controls :something

        button(:something, id: 'notThere')
      end
    end

    Then { on(has_controls) != nil }
    Then { expect { on(missing_controls) }.to raise_error /Control something was not found on the #<Class:0x.*> screen/ }
  end

  context Mohawk::Adapters do
    Given(:screen) { TestScreen.new }
    Given(:window) { double('window').as_null_object }
    Given do
      allow(screen.adapter).to receive(:window).and_return window
      allow(window).to receive(:present?)
    end

    context 'window' do
      context '#exist?' do
        When { screen.exist? }
        Then { expect(window).to have_received(:exist?) }
      end

      context '#active?' do
        When { screen.active? }
        Then { expect(window).to have_received(:active?) }
      end

      context '#present?' do
        When { screen.present? }
        Then { expect(window).to have_received(:present?) }
      end

      context 'has_text?' do
        Given { expect(window).to receive(:text).and_return 'lots of text, but blardy blar is in it' }
        Then { expect(screen).to have_text 'blardy blar' }
      end
    end

    context 'waiting' do
      context '#wait_until_present' do
        When { screen.wait_until_present }
        Then { expect(window).to have_received(:wait_until_present) }
      end

      context '#wait_until' do
        Then { screen.respond_to?(:wait_until) }
      end

      context '#wait_for_control' do
        Given do
          control = double 'control', exist?: true
          expect(screen.adapter).to receive(:control).with(id: 'whatever').and_return control
          control
        end

        Then { screen.wait_for_control id: 'whatever' }

        context 'not there' do
          Given { expect(screen).to receive(:wait_until).and_raise }
          Then { expect { screen.wait_for_control(id: 'whatever') }.to raise_error "A control with #{{id: 'whatever'}} was not found" }
        end
      end
    end
  end

end

