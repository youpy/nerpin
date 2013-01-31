require 'json'

module Nerpin
  class Nrpn
    attr_reader :id, :key, :min, :max

    def self.find_by_key(key)
      NRPN[key]
    end

    def initialize(id, key, min, max)
      @id  = id
      @key = key
      @min = min
      @max = max
    end

    def value(value)
      {
        :v0x06 => (value >= 0) ? value / 128 : 127 - (value.abs / 128),
        :v0x26 => (value >= 0) ? value % 128 : 128 - (value.abs % 128)
      }
    end

    def value_at(scale)
      value((((min.abs + max) * scale) - min.abs).to_i)
    end

    def sample
      value(rand(min.abs + max + (min < 0 ? 2 : 1)) - min.abs - (min < 0 ? 1 : 0))
    end

    # ruby -rnerpin -rjson -e "puts JSON.pretty_generate(Nerpin::SpecParser.parse)"
    data = JSON.parse(open(File.dirname(File.expand_path(__FILE__)) + '/../../data/nrpn/micron.json').read)

    NRPN = Hash[
      data.map do |k, v|
        [k.to_sym, new(v['id'], k.to_sym, v['min'], v['max'])]
      end
    ].freeze
  end
end
