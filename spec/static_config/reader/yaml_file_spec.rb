require 'spec_helper'
require 'static_config/reader/yaml_file'
require 'tempfile'

describe StaticConfig::Reader::YamlFile do
  let(:subject) { described_class.read(opts) }

  let(:file) { Tempfile.new('static_config_specs').tap { |f| f.write(yaml) ; f.close } }
  let(:base_opts) { { :file => file.path } }

  let(:opts) { base_opts }
  let(:yaml) { BASIC_YAML }
  it('loads the yaml') { should == { 'key' => 'value' } }

  context 'with section' do
    let(:yaml) { YAML_WITH_DEV }
    let(:opts) { base_opts.merge :section => 'dev' }
    it('uses the section') { should == { 'key' => 'value' } }
  end

  context 'with a section that does not exist' do
    let(:yaml) { YAML_WITH_DEV }
    let(:opts) { base_opts.merge :section => 'notthere' }
    it('is empty') { should == {} }
  end

  context 'with an empty file' do
    let(:yaml) { '' }
    it('is empty') { should == {} }

    context 'and a section' do
      let(:opts) { base_opts.merge :section => 'section' }
      it('is empty') { should == {} }
    end
  end

  context 'with a file that does not exist' do
    let(:opts) { { :file => "/does/not/exist" } }
    it('is empty') { should == {} }
  end

  context do
    let(:yaml) { "x: #{yaml_value}" }

    context 'string value' do
      let(:yaml_value) { '123abc123' }
      its(['x']) { should == '123abc123' }
    end

    context 'integer value' do
      let(:yaml_value) { '123' }
      its(['x']) { should == 123 }
    end

    context 'float value' do
      let(:yaml_value) { '1.5' }
      its(['x']) { should == 1.5 }
    end

    context 'false value' do
      let(:yaml_value) { 'false' }
      its(['x']) { should == false }
    end
  end

  BASIC_YAML = <<END_BASIC_YAML
key: value
END_BASIC_YAML

  YAML_WITH_DEV = <<END_YAML_WITH_DEV
dev:
  key: value
END_YAML_WITH_DEV
end
