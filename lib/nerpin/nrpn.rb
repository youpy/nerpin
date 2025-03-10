require 'json'

module Nerpin
  module Nrpn
    class Base
      attr_reader :id, :key, :min, :max

      class << self
        def find_by_key(key)
          nrpns[key]
        end

        def nrpns
          return @nrpns if @nrpns

          data = JSON.parse(
            File.read(
              File.dirname(
                File.expand_path(__FILE__)
              ) + "/../../data/nrpn/#{name.split('::').last.downcase}.json"
            )
          )

          @nrpns =
            data.map do |k, v|
              [k.to_sym, new(v['id'], k.to_sym, v['min'], v['max'])]
            end.to_h.freeze
        end
      end

      def initialize(id, key, min, max)
        @id  = id
        @key = key
        @min = min
        @max = max
      end

      def value(_value)
        raise 'subclass must override this'
      end

      def value_at(scale)
        value((((min.abs + max) * scale) - min.abs).to_i)
      end

      def sample
        value(rand(min.abs + max + (min < 0 ? 2 : 1)) - min.abs - (min < 0 ? 1 : 0))
      end
    end
  end
end
