require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Nerpin

describe SpecParser do
  describe '.parse' do
    before do
      @url = 'http://ion-micron-miniak.wikia.com/wiki/Common_FAQ'

      stub_request(:get, @url).
        to_return(:body => open(File.expand_path(File.dirname(__FILE__) + '/../micron.html')).read)
    end

    it 'parses the spec for NRPN' do
      parsed = SpecParser.parse

      parsed.should be_an_instance_of(Hash)
      parsed.size.should eql(234)
      parsed[:oscillator_1_pitch].should eql(
        :id  => 15,
        :min => -999,
        :max => 999
      )
      parsed[:lfo_1_rate_follow_tempo].should eql(
        :id  => 159,
        :min => 0,
        :max => 24
      )
      parsed[:tracking_point_minus1].should eql(
        :id  => 136,
        :min => -100,
        :max => 100
      )
    end
  end
end