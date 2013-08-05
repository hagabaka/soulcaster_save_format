require 'ostruct'

module Soulcaster
  class GameState < ::OpenStruct
    attr_accessor :bits

    FIELDS = [
      # name                         start length
      [ :total_time,                 0,    14     ],
      [ :death_count,                14,   7      ],
      [ :summon_count_archer,        21,   10     ],
      [ :summon_count_tank,          31,   10     ],
      [ :summon_count_bomber,        41,   10     ],
      [ :game_mode,                  51,   2      ],
      [ :gold,                       53,   17     ],
      [ :scrolls,                    70,   2      ],
      [ :potions,                    72,   2      ],
      [ :soul_orbs,                  74,   3      ],
      [ :starting_level,             77,   5      ],
      [ :archer_available,           82,   1      ],
      [ :archer_weapon_level,        83,   3      ],
      [ :archer_attack_speed_level,  86,   3      ],
      [ :archer_range_upgrade_level, 89,   3      ],
      [ :tank_available,             92,   1      ],
      [ :tank_weapon_level,          93,   3      ],
      [ :tank_attack_speed_level,    96,   3      ],
      [ :tank_range_upgrade_level,   99,   3      ],
      [ :bomber_available,           102,  1      ],
      [ :bomber_weapon_level,        103,  3      ],
      [ :bomber_attack_speed_level,  106,  3      ],
      [ :bomber_range_upgrade_level, 109,  3      ],
    ]

    ROTATION = [81, 91, 101, 31, 37, 41, 43, 47, 53, 7, 11, 13, 17, 19, 23, 29]

    def decode(bits)
      @bits = bits
      self.rotation = @rotation = read_bit_field 112, 4
      @checksum = read_bit_field 116, 4

      @bits = @bits[0, 112].rotate(- ROTATION[@rotation])

      read_fields
      self
    end

    def read_fields
      FIELDS.each do |(name, start, length)|
        self.send :"#{name}=", read_bit_field(start, length)
      end
    end

    def actual_checksum
      sum = @bits.inject(:+)
      sum2 = (sum >> 4) & 15
      (sum2 ^ ~sum) & 15
    end

    def checksum_match?
      actual_checksum == @checksum
    end

    def read_bit_field(start, length)
      @bits[start, length].each_with_index.inject(0) do |value, (bit, index)|
        value | (bit << index)
      end
    end
  end
end

