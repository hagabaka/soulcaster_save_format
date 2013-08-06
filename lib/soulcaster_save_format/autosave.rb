require 'soulcaster_save_format/password'

module Soulcaster
  # A Soul Caster autosave file is an XML file containing a Password element in a SoulcasterSave
  # element. The password is decoded using Soulcaster::Password
  class Autosave
    attr_accessor :password

    TEMPLATE = '<?xml version="1.0" encoding="utf-8"?><SoulcasterSave><Password>%s</Password></SoulcasterSave>'
    def initialize(password=nil)
      @password = password
    end

    def game_state
      @password && @password.game_state
    end

    REGEXP = Regexp.new Regexp.quote(TEMPLATE) % ['(.*)']
    def read(content)
      @password = Password.new.decode(content[REGEXP, 1])
      self
    end

    def to_s
      TEMPLATE % @password.to_s
    end
  end
end

