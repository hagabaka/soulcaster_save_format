require 'soulcaster/base32'
require 'soulcaster/game_state'

module Soulcaster
  class Password
    attr_accessor :information

    def initialize(information=nil)
      @information = information
    end

    def decode(content)
      stream = Base32.decode content
      @information = PasswordBits.read(stream)
      self
    end
  end
end

