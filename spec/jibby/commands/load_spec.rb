require 'spec_helper'
require 'ostruct'

describe Jibby::Commands::Load do
  describe '::run' do
    subject(:run) { Jibby::Commands::Load.run(application, ticket_key) }
    let(:application) { OpenStruct.new(console: console) }
    let(:console) { Jibby::Console.new }
    let(:ticket_key) { 'FOO-1' }
    let(:ticket_double) do
      double(summary: 'test')
    end

    before(:each) do
      allow(application).to receive(:load_ticket).and_return(ticket_double)
    end

    it { is_expected.to eql(true) }

    context 'ticket key not found' do
      it 'displays an error and returns true' do
        error = "#{ticket_key} was not found."
        allow(application).to receive(:load_ticket).and_return(nil)
        expect(console).to receive(:output).with(error)
        expect(run).to eql(true)
      end
    end
  end
end
