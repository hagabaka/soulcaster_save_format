require 'soulcaster/password'
require 'chloroplast/dsl'

def expect_field(game_state, field, value, password)
  it "correctly extracts #{field} from a password" do
    begin
      expect(game_state.send field).to be == value
    rescue RSpec::Expectations::ExpectationNotMetError => e
      e.message <<
        "\npassword: #{password}" +
        "\nrotation: #{game_state.rotation}" +
        "\n   field: #{field}"
      raise e
    end
  end
end

describe Soulcaster::Password do
  table = Chloroplast.new \
    | :password                  | :gold | :starting_level | :potions | :scrolls | :soul_orbs \
    | '------BC--RP-----P#-H-!C' | 98    | 1               | 0        | 0        | 1          \
    | '------SD-TRP------VA--ZC' | 147   | 1               | 1        | 1        | 1          \
    | '---XU-HIBA-A---KE--L-FPT' | 348   | 2               | 1        | 1        | 2          \
    | '---?X-HICA-A---FF--L-FPT' | 398   | 3               | 1        | 1        | 2          \
    | 'H-F-F-J-XLDP#HB-B-B-LYHI' | 1126  | 4               | 2        | 3        | 3          \
    | '--H-D-N-TID-=HB-B-B-?#HI' | 1101  | 4               | 3        | 2        | 3          \
    | 'BPAPAPB-XDALWR-P-P--WFLK' | 1176  | 5               | 2        | 3        | 3          \
    | 'H-N-P-T-?ZH-#LB-B-B-DHII' | 2263  | 6               | 2        | 2        | 3          \
    | '!-XMKP+NB-B-B-LOAA?APBTP' | 2926  | 7               | 3        | 1        | 3          \
    | 'PI-K-Q-BZFHOHA-A-A-BZPPE' | 3489  | 8               | 3        | 1        | 3          \
    | 'B-B-PGBEPCXDXFPOQ-?LJ-DX' | 1119  | 9               | 3        | 2        | 4          \
    | 'B-TUBEDDXFTG-=PAJTJ-H-H+' | 3134  | 10              | 1        | 1        | 4          \
    | 'NHUPT-IQDPXU-P-P--PZPAYA' | 4649  | 11              | 1        | 0        | 4          \
    | '?FGXIV-P-P-PWTIBFCGFZH-K' | 7388  | 12              | 3        | 2        | 4          \
    | '?FGXYV-P-P-PIUIBFCGFZH-K' | 7388  | 13              | 3        | 2        | 4          \
    | '#FQITX--K#B-B-B-HBGIXLL?' | 197   | 14              | 1        | 2        | 5          \
    | 'CJXF--I=B-B-BPHLGIPNX#TP' | 54    | 15              | 0        | 2        | 5          \
    | 'LIBLXADPKAC-B-BXVSHJLRL?' | 1038  | 16              | 1        | 3        | 5          \
    | 'B-EIIJXVDHESQB--+ML-H-H+' | 5     | 17              | 3        | 3        | 5          \
    | 'FHEFPVRA-A-APJYDENKVTH=T' | 3156  | 18              | 2        | 2        | 5          \
    | 'C-B-NB=BJKXXPI#WQZL-+#-X' | 821   | 19              | 3        | 3        | 5          \
    | 'O!N!RCAZWSV=TPJCS+GA+LCV' | 2557  | 29              | 3        | 3        | 4          \

  fields = table.instance_variable_get(:@headers)[1..-1]
  table.objects.each do |object|
    password = object.password
    game_state = Soulcaster::Password.new.decode(password).game_state

    expect_field game_state, :archer_available, 1, password

    expect_field game_state, :tank_available, object.starting_level >= 2 ? 1 : 0, password

    expect_field game_state, :bomber_available, object.starting_level >= 4 ? 1: 0, password

    fields.each do |field|
      expect_field game_state, field, object.send(field), password
    end
  end
end

