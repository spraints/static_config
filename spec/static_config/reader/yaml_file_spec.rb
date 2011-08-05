require 'spec_helper'
require 'static_config/reader/yaml_file'

describe StaticConfig::Reader::YamlFile do
  let(:subject) { described_class.read(opts) }

  def opts ; { :file => "#{__FILE__}.yml" } ; end
  it('loads the yaml') { should == { 'dev' => { 'key' => 'value' } } }

  context 'with prefix' do
    def opts ; super.merge :prefix => 'the.prefix' ; end
    it('adds a prefix') { should == { 'the' => { 'prefix' => { 'dev', { 'key' => 'value' } } } } }
  end

  context 'with section' do
    def opts ; super.merge :section => 'dev' ; end
    it('uses the section') { should == { 'key' => 'value' } }
  end

  context 'with a section that does not exist' do
    def opts ; super.merge :section => 'bad' ; end
    it('is empty') { should == {} }
  end

  context 'with prefix and section' do
    def opts ; super.merge :prefix => 'the.prefix', :section => 'dev' ; end
    it('adds a prefix to the section') { should == { 'the' => { 'prefix' => { 'key' => 'value' } } } }
  end
end
