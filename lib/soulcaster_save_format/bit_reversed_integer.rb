require 'bindata'

module Soulcaster
  # Bitr handles the bit-reversed integers used in the password binary stream.
  # These integers have their more significant bits written after less significant bits.
  # This is different from how BinData defines little-endian bit based integers.
  #
  # A Bitr of specific width is created using Bit*r, e.g. bit4r for a 4-bit Bitr
  class Bitr < BinData::Primitive
    mandatory_parameter :width
    array :bits, type: :bit1, initial_length: :width

    def get
      bits.to_a.reverse.join('').to_i(2)
    end

    def set(number)
      bit_string = "%0#{@params[:width]}B" % number
      new_bits = bit_string.split('').map(&:to_i)
      bits.assign new_bits.reverse
    end
  end

  [2, 3, 4, 5, 7, 10, 14, 17].each do |width|
    module_eval <<-END
      class Bit#{width}r < Bitr
        default_parameter width: #{width}
      end
    END
  end
end

