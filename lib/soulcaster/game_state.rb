require 'bindata'

module Soulcaster
  class GameStateBits < BinData::Array
    default_parameters type: bit1, initial_length: 112
  end

  class PasswordBits < BinData::Record
    game_state_bits :rotated_game_state
    bit4            :rotation_index
    bit4            :checksum

    ROTATION = [81, 91, 101, 31, 37, 41, 43, 47, 53, 7, 11, 13, 17, 19, 23, 29]
    def rotation
      ROTATION[rotation_index]
    end

    def rotated_game_state_bits
      rotated_game_state.to_a
    end

    def game_state
      unrotated_game_state_bits = GameStateBits.new
      unrotated_game_state_bits.assign rotated_game_state_bits.rotate(-rotation)
      GameState.read unrotated_game_state_bits.to_binary_s
    end

    def game_state=(new_game_state)
      new_game_state_bits = GameStateBits.read(new_game_state.to_binary_s).to_a
      rotated_game_state_bits.assign new_game_state_bits.rotate(rotation)
    end

    def actual_checksum
      sum = rotated_game_state_bits.inject(:+)
      sum2 = (sum >> 4) & 15
      (sum2 ^ ~sum) & 15
    end

    def checksum_match?
      actual_checksum == checksum
    end
  end

  class GameState < BinData::Record
    #                                 #  offset
    bit14 :total_time                 #  0
    bit7  :death_count                #  14
    bit10 :summon_count_archer        #  21
    bit10 :summon_count_tank          #  31
    bit10 :summon_count_bomber        #  41
    bit2  :game_mode                  #  51
    bit17 :gold                       #  53
    bit2  :scrolls                    #  70
    bit2  :potions                    #  72
    bit3  :soul_orbs                  #  74
    bit5  :starting_level             #  77
    bit1  :archer_available           #  82
    bit3  :archer_weapon_level        #  83
    bit3  :archer_attack_speed_level  #  86
    bit3  :archer_range_upgrade_level #  89
    bit1  :tank_available             #  92
    bit3  :tank_weapon_level          #  93
    bit3  :tank_attack_speed_level    #  96
    bit3  :tank_range_upgrade_level   #  99
    bit1  :bomber_available           #  102
    bit3  :bomber_weapon_level        #  103
    bit3  :bomber_attack_speed_level  #  106
    bit3  :bomber_range_upgrade_level #  109
  end
end

