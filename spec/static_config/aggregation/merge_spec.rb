require 'spec_helper'
require 'static_config/aggregation/merge'

describe StaticConfig::Aggregation::Merge do
  let(:subject) { described_class.new(readers) }

  class Reader
    def initialize(data)
      @read = data
    end
    attr_accessor :read
  end

  let(:reader_A) { Reader.new('a' => '1') }
  let(:reader_A2) { Reader.new('a' => '2') }
  let(:reader_B) { Reader.new('b' => '1') }
  let(:deep_reader_A) { Reader.new('really' => { 'deep' => { 'A' => '1' } }) }
  let(:deep_reader_B) { Reader.new('really' => { 'deep' => { 'B' => '1' } }) }

  context 'with one reader' do
    let(:readers) { [reader_A] }
    its(:read) { should == {'a' => '1'} }
  end

  context 'with two readers' do
    let(:readers) { [reader_A, reader_B] }
    its(:read) { should == {'a' => '1', 'b' => '1'} }
  end

  context 'with two readers with the same key' do
    let(:readers) { [reader_A, reader_A2] }
    its(:read) { should == {'a' => '2'} }
  end

  context 'with two deeply-nested results' do
    let(:readers) { [deep_reader_A, deep_reader_B] }
    its(:read) { should == {'really' => {'deep' => {'A' => '1', 'B' => '1'}}} }
  end

  context 'with false in the second reader' do
    let(:reader_with_false) { Reader.new('b' => false) }
    context 'and an empty reader first' do
      let(:readers) { [Reader.new({}), reader_with_false] }
      its(:read) { should == {'b' => false} }
    end
    context 'and a different value in the first reader' do
      let(:readers) { [reader_B, reader_with_false] }
      its(:read) { should == {'b' => false} }
    end
  end
end
