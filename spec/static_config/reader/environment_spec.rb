require 'spec_helper'
require 'static_config/reader/environment'

describe StaticConfig::Reader::Environment do
  def self.has_env(e)
    before do
      @original_env ||= {}
      e.each do |key, value|
        @original_env[key], ENV[key] = ENV[key], value
      end
    end
    after do
      e.each do |key, _|
        ENV[key] = @original_env[key]
      end
    end
  end

  let(:subject) { described_class.read(opts) }
  def opts ; { :env_prefix => 'MY_CONFIG' } ; end

  context do
    has_env 'MY_CONFIG_TEST' => 'value'
    it('reads environment') { should == { 'test' => 'value' } }
  end

  context do
    has_env 'MY_CONFIG_A_B_C' => 'D'
    it { subject['a_b_c'].should == 'D' }
    it { subject['a']['b_c'].should == 'D' }
    it { subject['a_b']['c'].should == 'D' }
    it { subject['a']['b']['c'].should == 'D' }
  end

  context do
    has_env({
      'MY_CONFIG_INT' => '123',
      'MY_CONFIG_TRUE' => 'true',
      'MY_CONFIG_FALSE' => 'false',
      'MY_CONFIG_FLOAT' => '123.45',
      'MY_CONFIG_STRING' => 'string',
      'MY_CONFIG_IP' => '10.10.10.10',
    })
    it { subject['int'].should == 123 }
    it { subject['true'].should == true }
    it { subject['false'].should == false }
    it { subject['float'].should == 123.45 }
    it { subject['string'].should == 'string' }
    it { subject['ip'].should == '10.10.10.10' }
  end
end

