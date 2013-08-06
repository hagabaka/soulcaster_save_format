require 'soulcaster_save_format/base32'
require 'soulcaster_save_format/game_state'

module Soulcaster
  # The password is a series of base 32 digits using a custom alphabet. Soulcaster::Base32
  # decodes it into a binary stream. Then Soulcaster::PasswordBits handles the structure
  # of the stream.
  class Password
    attr_accessor :information

    def initialize(information=nil)
      @information = information
    end

    def game_state
      @information && @information.game_state
    end

    def decode(content)
      stream = Base32.decode content
      @information = PasswordBits.read(stream)
      self
    end

    def to_s
      Base32.encode @information.to_binary_s
    end
  end
end

