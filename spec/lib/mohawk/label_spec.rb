require 'spec_helper'

describe 'labels' do
  Given(:main_screen) { start_app }

  Then { main_screen.sample_label == 'This is a sample text' }
  Then { main_screen.sample_label_view.class == Mohawk::Adapters::UIA::Control }
end
