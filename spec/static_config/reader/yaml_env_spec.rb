require 'spec_helper'
require 'static_config/reader/yaml_env'

describe StaticConfig::Reader::YamlEnv do
  let(:subject) { described_class.read(opts) }
  after  { ENV['my_config_yml'] = nil }
  before { ENV['my_config_yml'] = "dev:\n  key: value\n" }

  def opts ; { :env => 'my_config_yml' } ; end
  it('loads the yaml') { should == { 'dev' => { 'key' => 'value' } } }
end
