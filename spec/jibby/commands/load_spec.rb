require 'spec_helper'
require 'ostruct'

describe Jibby::Commands::Load do
  describe '::run' do
    subject(:run) { Jibby::Commands::Load.run(application_double, ticket_key) }
    let(:application_double) { OpenStruct.new(console: console) }
    let(:console) { Jibby::Console.new }
    let(:ticket_key) { 'FOO-1' }
    let(:ticket_hash) { {} }
    let(:ticket_double) { double(summary: 'foo') }

    before(:each) do
      allow(application_double).to receive(:load_ticket).and_return(ticket_hash)
      allow(Jibby::Ticket).to receive(:new).and_return(ticket_double)
    end

    it { is_expected.to eql(true) }
  end
end
