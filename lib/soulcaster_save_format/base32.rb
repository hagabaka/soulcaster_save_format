module Soulcaster
  module Base32
    ALPHABET = '-ABCDEFGHIJKLMNOPQRSTUVWXYZ!?#+='

    def self.decode(content)
      digits = content.chars.map {|character| ALPHABET.index character}
      bits = Array.new(digits.length * 5) do |index|
        div, mod = index.divmod 5
        (digits[div] >> mod) & 1
      end
      [bits.join].pack('B*')
    end

    def self.encode(binary_string)
      bits = binary_string.unpack('B*').first.split('').map &:to_i
      digits = bits.each_slice(5).map do |pentet|
        pentet.each_with_index.inject(0) do |sum, (bit, index)|
          sum + (bit << index)
        end
      end
      digits.inject('') {|string, digit| string + ALPHABET[digit]}
    end
  end
end

