module Soulcaster
  module Base32
    ALPHABET = '-ABCDEFGHIJKLMNOPQRSTUVWXYZ!?#+='

    def self.decode(content)
      digits = content.chars.map {|character| ALPHABET.index character}
      Array.new(digits.length * 5) do |index|
        div, mod = index.divmod 5
        (digits[div] >> mod) & 1
      end
    end
  end
end

