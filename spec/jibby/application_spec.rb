require 'spec_helper'

describe Jibby::Application do
  subject(:new_application) do
    Jibby::Application.new(gateway: gateway, interface: interface)
  end

  let(:gateway) { double }
  let(:interface) { nil }

  describe '::initialize' do
    it 'sets the necessary variables' do
      expect(new_application.instance_variable_get(:@gateway)).to eql(gateway)
      expect(new_application.instance_variable_get(:@current_key))
        .to eql(nil)
      expect(new_application.instance_variable_get(:@current_ticket))
        .to eql(nil)
    end
  end

  describe '#start' do
    let(:interface) { double }

    subject(:start_method) { new_application.start }
    context 'with false credentials' do
      it 'returns false' do
        allow(gateway).to receive(:credentials).and_return(false)
        expect(start_method).to eql(false)
      end
    end

    context 'after normal exit' do
      it 'returns true' do
        allow(gateway).to receive(:credentials).and_return(true)
        allow(interface).to receive(:clear_screen)
        allow(interface).to receive(:prompt).and_return('exit')
        expect(interface).to receive(:output).with('bye!')
        expect(start_method).to eql(true)
      end
    end
  end

  describe '#load_ticket' do
    subject(:load_method) { new_application.load_ticket(key) }
    let(:load_result) { double }
    let(:key) { 'FOO-1' }
    let(:ticket_double) { double(class: Jibby::Ticket) }

    it 'calls fetch_ticket on the gateway and forwards the return value' do
      expect(gateway).to receive(:fetch_ticket).and_return(load_result)
      allow(Jibby::Ticket).to receive(:new).and_return(ticket_double)
      expect(load_method.class).to eql(Jibby::Ticket)
    end

    it 'returns nil if a ticket could not be fetched' do
      allow(gateway).to receive(:fetch_ticket).and_return(nil)
      expect(load_method).to eql(nil)
    end
  end
end
