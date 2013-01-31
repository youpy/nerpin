require 'nokogiri'
require 'open-uri'

module Nerpin
  class SpecParser
    SPEC_URL = 'http://ion-micron-miniak.wikia.com/wiki/Common_FAQ'

    def self.parse
      doc   = Nokogiri::HTML(open(SPEC_URL))
      table = doc.xpath('//table').last

      table.xpath('tr').drop(1).inject({}) do |result, tr|
        id, key, min, max = tr.children.map do |el|
          el.text.strip
        end

        unless key.empty?
          key = key.downcase.
            gsub(/\-/, 'minus').
            gsub(/[\W]+/, '_').
            split('_').
            join('_').
            to_sym

          result[key] = {
            :id  => id.to_i,
            :min => min.to_i,
            :max => max.to_i
          }
        end

        result
      end
    end
  end
end
