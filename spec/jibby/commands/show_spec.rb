require 'spec_helper'
require 'stringio'
require 'ostruct'

describe Jibby::Commands::Show do
  describe '::run' do
    subject(:run) { Jibby::Commands::Show.run(application, attribute) }

    let(:application) do
      Jibby::Application.new(interface: interface, gateway: gateway)
    end

    let(:gateway) { Jibby::JiraGateway.new('http://foo.com') }
    let(:interface) { Jibby::Console.new(string_io) }
    let(:string_io) { StringIO.new }
    let(:attribute) { 'summary' }
    let(:ticket_double) do
      OpenStruct.new(summary: 'test',
                     description: 'food',
                     attributes: [:summary])
    end

    before(:each) do
      application.current_ticket = ticket_double
    end

    it { is_expected.to eql(true) }

    it 'outputs the summary via the interface' do
      expect(interface).to receive(:output).with(ticket_double.summary)
      run
    end

    context 'no current_ticket' do
      before(:each) { application.current_ticket = nil }

      it 'prints an error message and returns true' do
        expect(run).to eql(true)
        expect(string_io.string).to eql("Please load a ticket first.\n")
      end
    end

    context 'bad attribute' do
      let(:attribute) { 'foo' }

      it 'prints an error message and returns true' do
        expect(run).to eql(true)
        expect(string_io.string).to eql("Invalid attribute\n")
      end
    end
  end
end
