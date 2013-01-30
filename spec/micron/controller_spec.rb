require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Micron

describe Controller do
  before do
    @destination = double("CoreMIDI::Destination")
  end

  subject do
    Controller.new(@destination)
  end

  it 'controls the pitch of oscillator 1 with 999' do
    subject.should_receive(:puts).with(15, 999)

    subject.oscillator_1_pitch(999)
  end

  describe '#puts' do
    context 'nrpn is lower than 128' do
      it 'sends message to the destination' do
        @destination.should_receive(:puts).with(0b10110000, 99, 0)
        @destination.should_receive(:puts).with(0b10110000, 98, 15)
        @destination.should_receive(:puts).with(0b10110000, 6,  0)
        @destination.should_receive(:puts).with(0b10110000, 38, 0)

        subject.puts(15, 0)
      end
    end

    context 'nrpn is higher than 127' do
      it 'sends message to the destination' do
        @destination.should_receive(:puts).with(0b10110000, 99, 1)
        @destination.should_receive(:puts).with(0b10110000, 98, 54)
        @destination.should_receive(:puts).with(0b10110000, 6,  anything())
        @destination.should_receive(:puts).with(0b10110000, 38, anything())

        subject.puts(182, 0)
      end
    end

    context 'zero value' do
      it 'sends message to the destination' do
        @destination.should_receive(:puts).with(0b10110000, 99, anything())
        @destination.should_receive(:puts).with(0b10110000, 98, anything())
        @destination.should_receive(:puts).with(0b10110000, 6,  0)
        @destination.should_receive(:puts).with(0b10110000, 38, 0)

        subject.puts(15, 0)
      end
    end

    context 'positive value' do
      it 'sends message to the destination' do
        @destination.should_receive(:puts).with(0b10110000, 99, anything())
        @destination.should_receive(:puts).with(0b10110000, 98, anything())
        @destination.should_receive(:puts).with(0b10110000, 6,  1)
        @destination.should_receive(:puts).with(0b10110000, 38, 15)

        subject.puts(15, 143)
      end
    end

    context 'negative value' do
      it 'sends message to the destination' do
        @destination.should_receive(:puts).with(0b10110000, 99, anything())
        @destination.should_receive(:puts).with(0b10110000, 98, anything())
        @destination.should_receive(:puts).with(0b10110000, 6,  126)
        @destination.should_receive(:puts).with(0b10110000, 38, 113)

        subject.puts(15, -143)
      end
    end
  end
end
