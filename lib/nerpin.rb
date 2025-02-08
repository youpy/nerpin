require 'nerpin/nrpn'
require 'nerpin/nrpn/micron'
require 'nerpin/controller'
require 'nerpin/util'
require 'nerpin/version'

module Nerpin
  def Micron(destination) # rubocop:disable Naming/MethodName
    Controller.new(destination, Nerpin::Nrpn::Micron)
  end

  module_function :Micron
end
