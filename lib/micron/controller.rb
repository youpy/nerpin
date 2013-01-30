module Micron
  class Controller
    def initialize(destination)
      @destination = destination
    end

    def puts(id, value)
      mutex.synchronize do
        [
          [0x63, id / 128],
          [0x62, id % 128],
          [0x06, (value >= 0) ? value / 128 : 127 - (value.abs / 128)],
          [0x26, (value >= 0) ? value % 128 : 128 - (value.abs % 128)]
        ].each do |message|
          @destination.puts(0b10110000, message[0], message[1])
        end
      end
    end

    private

    def mutex
      @mutex ||= Mutex.new
    end

    def method_missing(name, *args)
      if nrpn = Nrpn.find_by_key(name)
        puts(nrpn.id, args.first)
      else
        super
      end
    end
  end
end
