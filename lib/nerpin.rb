require "nerpin/nrpn"
require "nerpin/nrpn/micron"
require "nerpin/controller"
require "nerpin/util"
require "nerpin/version"

module Nerpin
  ObjectSpace.each_object(class << Nrpn::Base; self; end) do |m|
    if m != Nrpn::Base
      name = m.name.split(/::/).last.to_sym

      define_method(name) do |destination|
        Controller.new(destination, m)
      end

      module_function name
    end
  end
end
