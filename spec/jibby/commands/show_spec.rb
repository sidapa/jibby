require 'spec_helper'
require 'ostruct'

describe Jibby::Commands::Show do
  describe '::run' do
    subject(:run) { Jibby::Commands::Show.run(application, attribute) }

    let(:application) do
      Jibby::Application.new(console: console, gateway: gateway)
    end

    let(:gateway) { Jibby::JiraGateway.new('http://foo.com') }
    let(:console) { Jibby::Console.new }
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

    it 'outputs the summary via the console' do
      expect(console).to receive(:output).with(ticket_double.summary)
      run
    end

    context 'no current_ticket' do
      before(:each) { application.current_ticket = nil }

      it 'prints an error message and returns true' do
        expect(console).to receive(:output).with('Please load a ticket first.')
        expect(run).to eql(true)
      end
    end

    context 'bad attribute' do
      let(:attribute) { 'foo' }

      it 'prints an error message and returns true' do
        expect(console).to receive(:output).with('Invalid attribute')
        expect(run).to eql(true)
      end
    end
  end
end
