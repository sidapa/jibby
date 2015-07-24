require 'spec_helper'

describe Jibby::Application do
  subject(:new_application) do
    Jibby::Application.new(gateway: gateway, console: console)
  end

  let(:gateway) { double }
  let(:console) { double }

  describe '::initialize' do
    it 'sets the necessary variables' do
      expect(new_application.instance_variable_get(:@gateway)).to eql(gateway)
      expect(new_application.instance_variable_get(:@console)).to eql(console)
      expect(new_application.instance_variable_get(:@current_key))
        .to eql(nil)
      expect(new_application.instance_variable_get(:@current_ticket))
        .to eql(nil)
    end
  end

  describe '#start' do
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
        allow(console).to receive(:clear_screen)
        allow(console).to receive(:prompt).and_return('exit')
        expect(start_method).to eql(true)
      end
    end
  end

  describe '#load_ticket' do
    subject(:load_method) { new_application.load_ticket }
    let(:load_result) { double }

    it 'calls load_ticket on the gateway and forwards the return value' do
      expect(gateway).to receive(:load_ticket).and_return(load_result)
      expect(load_method).to eql(load_result)
    end
  end
end
