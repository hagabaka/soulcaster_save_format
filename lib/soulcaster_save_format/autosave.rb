require 'soulcaster/password'

module Soulcaster
  class Autosave
    attr_accessor :password

    TEMPLATE = '<?xml version="1.0" encoding="utf-8"?><SoulcasterSave><Password>%s</Password></SoulcasterSave>'
    def initialize(password=nil)
      @password = password
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

