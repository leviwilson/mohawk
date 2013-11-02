require 'ffi'

module Mohawk
  module Win32
    extend FFI::Library
    ffi_lib 'user32.dll'
    attach_function :foreground_window, :GetForegroundWindow, [], :int
  end
end