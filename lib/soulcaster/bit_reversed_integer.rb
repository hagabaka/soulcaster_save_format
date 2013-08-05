require 'bindata'

module Soulcaster
  class Bitr < BinData::Primitive
    mandatory_parameter :width
    array :bits, type: :bit1, initial_length: :width

    def get
      bits.to_a.reverse.join('').to_i(2)
    end

    def set(number)
      bit_string = "%0#{@params[:width]}B" % number
      bits = bit_string.split('').map(&:to_i)
      bits.assign bits
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

