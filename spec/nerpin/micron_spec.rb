require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe Nerpin do
  before do
    @destination = double('CoreMIDI::Destination')
  end

  describe '::Micron' do
    it 'returns a controller for micron' do
      Nerpin::Controller.should_receive(:new).with(@destination, Nerpin::Nrpn::Micron)

      Nerpin::Micron(@destination)
    end
  end
end
