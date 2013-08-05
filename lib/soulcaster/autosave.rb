require 'soulcaster/password'

module Soulcaster
  class Autosave
    attr_accessor :password

    TEMPLATE = '<?xml version="1.0" encoding="utf-8"?><SoulcasterSave><Password>%s</Password></SoulcasterSave>'
    def initialize(password)
      @password = password
    end

    REGEXP = Regexp.new Regexp.quote(TEMPLATE) % ['(.*)']
    def self.read(content)
      self.new Password.decode(content[REGEXP, 1])
    end

    def to_s
      TEMPLATE % @password.to_s
    end
  end
end

