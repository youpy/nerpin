require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Micron

describe Nrpn do
  subject do
    Nrpn.new(15, :oscillator_1_pitch, -999, 999)
  end

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

  describe '#value_at' do
    it 'returns value at given scaled value' do
      subject.value_at(0.0).should eql(-999)
      subject.value_at(0.5).should eql(0)
      subject.value_at(1.0).should eql(999)
    end
  end

  its(:id)  { should eql(15) }
  its(:key) { should eql(:oscillator_1_pitch) }
  its(:max) { should eql(999) }
  its(:min) { should eql(-999) }
end
