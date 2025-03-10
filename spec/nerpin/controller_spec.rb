require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

module Nerpin
  describe Controller do
    before do
      @destination = double('CoreMIDI::Destination')
    end

    subject do
      Controller.new(@destination, Nrpn::Micron)
    end

    it 'controls the pitch of oscillator 1 with 999' do
      subject.should_receive(:puts).with(15, v0x06: 7, v0x26: 103)
      subject.respond_to?(:oscillator_1_pitch).should be_true

      subject.oscillator_1_pitch(999)
    end

    describe '#puts' do
      it 'sends message with specified value to the destination' do
        @destination.should_receive(:puts).with(0b10110000, 99, anything)
        @destination.should_receive(:puts).with(0b10110000, 98, anything)
        @destination.should_receive(:puts).with(0b10110000, 6,  5)
        @destination.should_receive(:puts).with(0b10110000, 38, 123)

        subject.puts(15, v0x06: 5, v0x26: 123)
      end

      context 'nrpn is lower than 128' do
        it 'sends message to the destination' do
          @destination.should_receive(:puts).with(0b10110000, 99, 0)
          @destination.should_receive(:puts).with(0b10110000, 98, 15)
          @destination.should_receive(:puts).with(0b10110000, 6,  anything)
          @destination.should_receive(:puts).with(0b10110000, 38, anything)

          subject.puts(15, v0x06: 0, v0x26: 0)
        end
      end

      context 'nrpn is higher than 127' do
        it 'sends message to the destination' do
          @destination.should_receive(:puts).with(0b10110000, 99, 1)
          @destination.should_receive(:puts).with(0b10110000, 98, 54)
          @destination.should_receive(:puts).with(0b10110000, 6,  anything)
          @destination.should_receive(:puts).with(0b10110000, 38, anything)

          subject.puts(182, v0x06: 0, v0x26: 0)
        end
      end
    end

    describe '#nrpns' do
      it 'return NRPNs' do
        subject.nrpns.size.should eql(234)
        subject.nrpns.values.first.should be_a_kind_of(Nrpn::Base)
      end
    end
  end
end
