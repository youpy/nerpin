require 'nokogiri'
require 'open-uri'

module Nerpin
  module Util
    # ruby -rnerpin -rjson -e "puts JSON.pretty_generate(Nerpin::Util.parse_spec_for_micron)"
    def self.parse_spec_for_micron
      spec_url = 'http://ion-micron-miniak.wikia.com/wiki/Common_FAQ'
      doc      = Nokogiri::HTML(URI.parse(spec_url).open)
      table    = doc.xpath('//table').last

      table.xpath('tr').drop(1).each_with_object({}) do |tr, result|
        _, id, key, min, max = tr.children.map do |el|
          el.text.strip
        end

        next if key.empty?

        key = key.downcase
                 .gsub('-', 'minus')
                 .gsub(/\W+/, '_')
                 .split('_')
                 .join('_')
                 .to_sym

        result[key] = {
          id: id.to_i,
          min: min.to_i,
          max: max.to_i
        }
      end
    end
  end
end
