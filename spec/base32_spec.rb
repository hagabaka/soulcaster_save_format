# coding: binary

require 'soulcaster/base32'
require 'chloroplast/dsl'

describe Soulcaster::Base32 do
  table = Chloroplast.new \
  | :password                  | :string                                                  \
  | '-'*24                     | "\x00"*15                                                \
  | '='*24                     | "\xff"*15                                                \
  | '------BC--RP-----P#-H-!C' | "\x00\x00\x00\x01\x18\x00\x12\x10\x00\x00\x00n\x01\x03x" \
  | '------SD-TRP------VA--ZC' | "\x00\x00\x00\x03$\x01R\x10\x00\x00\x00\e\x00\x01x"      \
  | '---XU-HIBA-A---KE--L-FPT' | "\x00\x00:\x80RD\x01\x00\x00\x1A\xA0\x00`0%"             \
  | '---?X-HICA-A---FF--L-FPT' | "\x00\x00q\x80R\xC4\x01\x00\x00\f`\x00`0%"               \
  | 'H-F-F-J-XLDP#HB-B-B-LYHI' | "\x10\x18\x06\x01@\x19\x88\e\x89\x00@\x10\x03LR"         \
  | '--H-D-N-TID-=HB-B-B-?#HI' | "\x00\x04\x02\x01\xC0,\x88\x0F\x89\x00@\x10\x03\xDCR"    \
  | 'BPAPAPB-XDALWR-P-P--WFLK' | "@`\x18\x05\x00\x19 n\xA4\x01\x00@\x0E\xB0\xDA"          \
  | 'H-N-P-T-?ZH-#LB-B-B-DHII' | "\x10\x1C\x00\x80\xA0:\xC4\v\x99\x00@\x10\x02\nR"        \
  | '!-XMKP+NB-B-B-LOAA?APBTP' | "\xD8\am\x05\xEE@\x10\x04\x00\xDE\x84\x0F\x00\xA0\xA1"   \
  | 'PI-K-Q-BZFHOHA-A-A-BZPPE' | "\f\x81\xA0D\b[\x05\xE1@\x10\x04\x00\x85\x844"           \
  | 'B-B-PGBEPCXDXFPOQ-?LJ-DX' | "@\x10\x00\xF1\x14\x0E\x06A\xB0>\x88\x0Ee\x00\x83"       \
  | 'B-TUBEDDXFTG-=PAJTJ-H-H+' | "@\vTP\x84\e\v\xC0|0QT\x01\x00O"                         \
  | 'NHUPT-IQDPXU-P-P--PZPAYA' | "p\xAA\x12\x82Q GP\x04\x01\x00\x02\xB0\xC2p"             \
  | '?FGXIV-P-P-PWTIBFCGFZH-K' | ";894\x01\x00@\x1E\x96Hf8\xC5\x88\x1A"                   \
  | '?FGXYV-P-P-PIUIBFCGFZH-K' | ";89\xB4\x01\x00@\x19VHf8\xC5\x88\x1A"                   \
  | '#FQITX--K#B-B-B-HBGIXLL?' | "\xBB#\"\x8C\x00\xD5\xD0\x04\x01\x00\x129!\x98\xC7"      \
  | 'CJXF--I=B-B-BPHLGIPNX#TP' | "\xC2\x86\xC0\x02_@\x10\x04\x04F\xE4\x82\xE1\xDC\xA1"    \
  | 'LIBLXADPKAC-B-BXVSHJLRL?' | "4\x90a\xC0\x81\xD40\x04\x01\x03nD\xA3$\xC7"             \
  | 'B-EIIJXVDHESQB--+ML-H-H+' | "@))(m \xA9\x98\xA0\x00}\x8C\x01\x00O"                   \
  | 'FHEFPVRA-A-APJYDENKVTH=T' | "`\xA8\xC0\xB50\x04\x01\x00\xAAd\xA3\xB4\xD2\x8B\xE5"    \
  | 'C-B-NB=BJKXXPI#WQZL-+#-X' | "\xC0\x10\a#\xE8V\x860\xCA\xFD\x8A\xCC\a\xDC\x03"        \
  | 'O!N!RCAZWSV=TPJCS+GA+LCV' | "\xF6\xDD\xB4\xE2\v\xEE[\xF2\x85X\xCB\xF9\a\x9B\r"       \

  table.objects.each do |entry|
    it 'decodes a base32 string' do
      expect(Soulcaster::Base32.decode(entry.password)).to be == entry.string
    end
  end
end

