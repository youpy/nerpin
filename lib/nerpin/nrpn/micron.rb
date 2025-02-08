module Nerpin
  module Nrpn
    class Micron < Base
      def value(value)
        {
          v0x06: value >= 0 ? value / 128 : 127 - (value.abs / 128),
          v0x26: value >= 0 ? value % 128 : 128 - (value.abs % 128)
        }
      end
    end
  end
end
