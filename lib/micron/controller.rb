module Micron
  class Controller
    def initialize(destination)
      @destination = destination
    end

    def puts(id, value)
      mutex.synchronize do
        [
          [0x63, (id >> 7) & 0b1111111],
          [0x62, id        & 0b1111111],
          [0x06, value[:v0x06]],
          [0x26, value[:v0x26]]
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
        puts(nrpn.id, nrpn.value(args.first))
      else
        super
      end
    end
  end
end
