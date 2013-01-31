require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Nerpin

describe Nrpn do
  subject do
    Nrpn.new(15, :oscillator_1_pitch, -999, 999)
  end

  its(:id)  { should eql(15) }
  its(:key) { should eql(:oscillator_1_pitch) }
  its(:max) { should eql(999) }
  its(:min) { should eql(-999) }

  describe '.find_by_key' do
    it 'finds NRPN by key' do
      Nrpn.find_by_key(:oscillator_1_pitch).should be_an_instance_of(Nrpn)
    end
  end

  describe '#initialize' do
    it 'instantiates' do
      subject.should be_an_instance_of(Nrpn)
    end
  end

  describe '#value' do
    context 'lower than 128' do
      it do
        subject.value(123).should eql(:v0x06 => 0, :v0x26 => 123)
      end
    end

    context 'higher than 127' do
      it do
        subject.value(129).should eql(:v0x06 => 1, :v0x26 => 1)
      end
    end

    context 'zero' do
      it do
        subject.value(0).should eql(:v0x06 => 0, :v0x26 => 0)
      end
    end

    context 'nagative value, higher than -128' do
      it do
        subject.value(-127).should eql(:v0x06 => 127, :v0x26 => 1)
      end
    end

    context 'nagative value, lower than -127' do
      it do
        subject.value(-128).should eql(:v0x06 => 126, :v0x26 => 128)
      end
    end
  end

  describe '#value_at' do
    it 'returns nrpn value at given scaled value' do
      subject.value_at(0.0).should eql(:v0x06 => 120, :v0x26 => 25)
      subject.value_at(0.5).should eql(:v0x06 => 0, :v0x26 => 0)
      subject.value_at(1.0).should eql(:v0x06 => 7, :v0x26 => 103)
    end
  end
end
