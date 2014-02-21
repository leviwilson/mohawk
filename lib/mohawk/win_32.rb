require 'ffi'

module Mohawk
  module Win32
    extend FFI::Library
    ffi_lib 'user32.dll'
    attach_function :set_foreground_window, :SetForegroundWindow, [:long], :bool
    attach_function :foreground_window, :GetForegroundWindow, [], :int
    attach_function :is_window, :IsWindow, [:int], :bool
    attach_function :activate, :SetActiveWindow, [:int], :int
  end
end