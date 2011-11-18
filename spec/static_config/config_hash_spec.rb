require 'spec_helper'
require 'static_config/config_hash'

describe StaticConfig::ConfigHash do
  let(:subject) { StaticConfig::ConfigHash.new({'a' => 'ok', 'nested' => { 'key' => 'also ok' }, 'nottrue' => false}) }

  its('a')          { should == 'ok' }
  its('nested')     { should == { 'key' => 'also ok' } }
  its('nested.key') { should == 'also ok' }
  its('missing')    { should be_nil }
  its('nottrue')    { should == false }
end
