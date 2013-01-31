require "nerpin/nrpn"
require "nerpin/nrpn/micron"
require "nerpin/controller"
require "nerpin/util"
require "nerpin/version"

module Nerpin
  def Micron(destination)
    Controller.new(destination, Nrpn::Micron)
  end
end
