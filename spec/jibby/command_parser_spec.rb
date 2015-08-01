require 'spec_helper'

describe Jibby::CommandParser do
  subject(:parser) { Jibby::CommandParser }

  let(:method) { 21.method(:nil?) }
  let(:name) { :foo }

  before(:each) do
    Jibby::CommandParser.instance_variable_set(:@commands, {})
  end
  describe '::add_command' do
    subject(:add_command_method) { parser.add_command(name, method) }

    it 'adds to the @commands hash' do
      expect { add_command_method }.to change {
        Jibby::CommandParser.instance_variable_get(:@commands).size
      }.by(1)
    end

    context 'passing a non-method object' do
      let(:method) { 21 }

      it 'should fail' do
        expect { add_command_method }.to raise_error ArgumentError
      end
    end

    context 'passing a non string or non symbol name' do
      let(:name) { 21 }

      it 'should fail' do
        expect { add_command_method }.to raise_error ArgumentError
      end
    end

    context 'passing an array of keys' do
      let(:name) { [:foo, :bar] }

      it 'adds to the @commands hash' do
        expect { add_command_method }.to change {
          Jibby::CommandParser.instance_variable_get(:@commands).size
        }.by(2)
      end
    end
  end

  describe '::parse' do
    subject(:parse_method) do
      parser.parse(application: application_double, input: input)
    end

    before(:each) do
      allow(method).to receive(:class).and_return(Method)
      parser.add_command(name, method)
    end

    let(:method) { double }
    let(:application_double) { double(interface: Jibby::Console.new) }
    let(:input) { "#{call_name} #{param}" }
    let(:param) { 'opt' }
    let(:call_name) { :foo }

    it 'calls the method depending on the key' do
      expect(method).to receive(:call).with(application_double, param)
      parse_method
    end

    context 'key is not registered' do
      let(:call_name) { :not_foo }

      it { is_expected.to eql(true) }
    end
  end
end
