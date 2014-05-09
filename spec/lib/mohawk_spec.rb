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
      Uia.stub(:find_element).and_return double
      process.stub(:start).and_return(process)
      [:exited?, :stop].each &process.method(:stub)
      ChildProcess.stub(:build).with('./the/app/path.exe').and_return(process)

      window.stub(:present?).and_return(true)

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
      Given { Mohawk.start }
      When { Mohawk.stop }
      Then { expect(process).to have_received(:stop) }
    end

    it 'knows if a process was never started' do
      lambda { Mohawk.stop }.should raise_error('An application was never started')
    end

    it 'does nothing if the process has exited' do
      process.should_receive(:exited?).and_return(true)
      process.should_not_receive(:stop)
      Mohawk.start

      Mohawk.stop
    end

    it 'has a clean slate if the application has been stopped' do
      Mohawk.start
      Mohawk.stop
      Mohawk.app.should be_nil
    end
  end

  context Mohawk::Adapters::UiaAdapter do
    Given(:window) do
      window = double 'window', element: element
      expect(Mohawk::Adapters::UIA::Window).to receive(:new).and_return window
      window
    end
    Given(:element) { double 'element' }

    it "knows if a window exists" do
      window.should_receive(:exist?)
      screen.exist?
    end

    it "knows if a window is active or not" do
      window.should_receive(:active?)
      screen.active?
    end

    it "knows if the window is present" do
      window.should_receive(:present?)
      screen.present?
    end

    it "can hold off until the window is present" do
      window.should_receive(:wait_until_present)
      screen.wait_until_present
    end

    it "can hold off until I say so" do
      window.should_receive(:present?).twice.and_return(false, true)
      screen.wait_until {screen.present?}
    end

    it "can wait for a control" do
      expect(screen.adapter).to receive(:control).with(id: 'whatever', index: 0).and_return(double exist?: true)
      screen.wait_for_control(id: 'whatever', index: 0)
    end

    it "tells you what you were waiting for if it fails" do
      screen.should_receive(:wait_until).and_raise
      locator = {id: 'whatever', index: 0}
      expect { screen.wait_for_control(id: 'whatever', index: 0) }.to raise_error(Exception, "A control with #{locator} was not found")
    end

    it "knows if a window has text" do
      window.should_receive(:text).and_return("lots of text but I wanted to find blardy blar blar")
      screen.should have_text "blardy blar"
    end
    
  end
end
