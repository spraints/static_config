require 'spec_helper'
require 'static_config/reader/environment'

describe StaticConfig::Reader::Environment do
  before do
    ENV['MY_CONFIG_DEV_KEY'] = 'value'
  end
  after do
    ENV['MY_CONFIG_DEV_KEY'] = nil
  end
  let(:subject) { described_class.read(opts) }

  def opts ; { :env_prefix => 'MY_CONFIG' } ; end
  it('reads environment') { should == { 'dev' => { 'key' => 'value' } } }
end

