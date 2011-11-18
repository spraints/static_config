require 'spec_helper'
require 'static_config/config_proxy'

describe StaticConfig::ConfigProxy do
  let(:subject) { described_class.new(reader) }

  context do
    class SimpleReader
      def read
        {'a' => 'ok', 'nested' => { 'key' => 'also ok' }, 'nottrue' => false}
      end
    end
    let(:reader)  { SimpleReader.new }

    its('a')          { should == 'ok' }
    its('nested')     { should == { 'key' => 'also ok' } }
    its('nested.key') { should == 'also ok' }
    its('missing')    { should be_nil }
    its('nottrue')    { should == false }
  end

  context do
    class ChangeableReader
      attr_accessor :read
    end
    let(:reader) { ChangeableReader.new }
    it 're-reads' do
      reader.read = { 'a' => 'old' }
      expect{subject.reload! ; reader.read = { 'a' => 'new' }}.to change{subject.a}.from('old').to('new')
    end
  end
end
