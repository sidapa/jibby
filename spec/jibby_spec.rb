require 'spec_helper'

describe Jibby do
  let(:host) { 'http://foo.bar' }

  it 'has a version number' do
    expect(Jibby::VERSION).not_to be nil
  end

  describe '::start' do
    let(:console_double) { double }

    it 'calls start on a new instance of console' do
      expect(Jibby::Console).to receive(:new).and_return(console_double)
      expect(console_double).to receive(:start)

      Jibby.start(host)
    end
  end

  describe '::gateway' do
    subject(:gateway) { Jibby.send(:gateway, host) }

    let(:result_double) { double }

    it 'returns a new instance of JiraGateway' do
      expect(Jibby::JiraGateway).to receive(:new).with(host)
        .and_return(result_double)
      expect(gateway).to eql(result_double)
    end
  end
end
