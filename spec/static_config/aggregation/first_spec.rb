require 'spec_helper'
require 'static_config/aggregation/first'

describe StaticConfig::Aggregation::First do
  let(:subject) { described_class.new(readers) }

  class Reader
    def initialize(data)
      @read = data
    end
    attr_accessor :read
  end

  let(:nil_reader) { Reader.new(nil) }
  let(:empty_reader) { Reader.new({}) }
  let(:reader_A) { Reader.new('a' => '1') }
  let(:reader_B) { Reader.new('b' => '1') }

  context 'with a not-empty reader' do
    let(:readers) { [reader_A] }
    its(:read) { should == {'a' => '1'} }
  end

  context 'with just a nil reader' do
    let(:readers) { [nil_reader] }
    its(:read) { should == {} }
  end

  context 'with an empty and not-empty reader' do
    let(:readers) { [empty_reader, reader_A] }
    its(:read) { should == {'a' => '1'} }
  end

  context 'with two readers' do
    let(:readers) { [reader_B, reader_A] }
    its(:read) { should == {'b' => '1'} }
  end

  context 'with false in the first reader' do
    let(:reader_with_false) { Reader.new('b' => false) }
    context 'and an empty reader second' do
      let(:readers) { [reader_with_false, empty_reader] }
      its(:read) { should == {'b' => false} }
    end
    context 'and a value in the second reader' do
      let(:readers) { [reader_with_false, reader_B] }
      its(:read) { should == {'b' => false} }
    end
  end
end
