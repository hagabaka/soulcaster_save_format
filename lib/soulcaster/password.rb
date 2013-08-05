require 'soulcaster/base32'
require 'soulcaster/game_state'

module Soulcaster
  class Password
    attr_accessor :game_state

    def initialize(game_state=nil)
      @game_state = game_state
    end

    def decode(content)
      digits = Base32.decode content
      @game_state = GameState.new.decode(digits)
      self
    end
  end
end

