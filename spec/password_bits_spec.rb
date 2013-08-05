require 'soulcaster_save_format/game_state'
require 'chloroplast/dsl'

describe Soulcaster::PasswordBits do
  table = Chloroplast.new \
  | :string                                                  | :rotation_index \
  | "\x00\x00\x00\x01\x18\x00\x12\x10\x00\x00\x00n\x01\x03x" | 14              \
  | "\x00\x00\x00\x03$\x01R\x10\x00\x00\x00\e\x00\x01x"      | 14              \
  | "\x00\x00:\x80RD\x01\x00\x00\x1A\xA0\x00`0%"             | 4               \
  | "\x00\x00q\x80R\xC4\x01\x00\x00\f`\x00`0%"               | 4               \
  | "\x10\x18\x06\x01@\x19\x88\e\x89\x00@\x10\x03LR"         | 10              \
  | "\x00\x04\x02\x01\xC0,\x88\x0F\x89\x00@\x10\x03\xDCR"    | 10              \
  | "@`\x18\x05\x00\x19 n\xA4\x01\x00@\x0E\xB0\xDA"          | 11              \
  | "\x10\x1C\x00\x80\xA0:\xC4\v\x99\x00@\x10\x02\nR"        | 10              \
  | "\xD8\am\x05\xEE@\x10\x04\x00\xDE\x84\x0F\x00\xA0\xA1"   | 5               \
  | "\f\x81\xA0D\b[\x05\xE1@\x10\x04\x00\x85\x844"           | 12              \
  | "@\x10\x00\xF1\x14\x0E\x06A\xB0>\x88\x0Ee\x00\x83"       | 1               \
  | "@\vTP\x84\e\v\xC0|0QT\x01\x00O"                         | 2               \
  | "p\xAA\x12\x82Q GP\x04\x01\x00\x02\xB0\xC2p"             | 14              \
  | ";894\x01\x00@\x1E\x96Hf8\xC5\x88\x1A"                   | 8               \
  | ";89\xB4\x01\x00@\x19VHf8\xC5\x88\x1A"                   | 8               \
  | "\xBB#\"\x8C\x00\xD5\xD0\x04\x01\x00\x129!\x98\xC7"      | 3               \
  | "\xC2\x86\xC0\x02_@\x10\x04\x04F\xE4\x82\xE1\xDC\xA1"    | 5               \
  | "4\x90a\xC0\x81\xD40\x04\x01\x03nD\xA3$\xC7"             | 3               \
  | "@))(m \xA9\x98\xA0\x00}\x8C\x01\x00O"                   | 2               \
  | "`\xA8\xC0\xB50\x04\x01\x00\xAAd\xA3\xB4\xD2\x8B\xE5"    | 7               \
  | "\xC0\x10\a#\xE8V\x860\xCA\xFD\x8A\xCC\a\xDC\x03"        | 0               \
  | "\xF6\xDD\xB4\xE2\v\xEE[\xF2\x85X\xCB\xF9\a\x9B\r"       | 0               \

  table.objects.each do |entry|
    it 'correct extracts rotation from a password' do
      expect(Soulcaster::PasswordBits.read(entry.string).rotation_index).to be ==
        entry.rotation_index
    end
  end

end
