# Guardfile
notification :tmux,
  :display_message => true,
  :timeout => 5, # in seconds
  :default_message_format => '%s >> %s',
  :line_separator => ' > ', # since we are single line we need a separator
  :color_location => 'status-left-bg' # to customize which tmux element will change color

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('lib/mohawk/accessors.rb')     { |m| "spec/lib/mohawk/accessors" }
  watch(%r{^lib/mohawk/(.+)\.rb$})     { |m| "spec/lib/mohawk/#{m[1]}_spec.rb" }
  watch(%r{^lib/mohawk/accessors/(.+)\.rb$})     { |m| "spec/lib/mohawk/accessors/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
