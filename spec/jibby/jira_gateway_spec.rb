require 'spec_helper'

describe Jibby::JiraGateway do
  describe '::initialize' do
    subject(:new_gateway) { Jibby::JiraGateway.new(host) }
    let(:host) { 'http://foo.bar' }
    let(:parsed_host) { URI.parse(host) }

    it 'uses URI to parse the gateway' do
      expect(URI).to receive(:parse).with(host)
      new_gateway
    end

    it 'sets the parsed host to the @host variable' do
      expect(new_gateway.instance_variable_get(:@host)).to eql(parsed_host)
    end
  end

  describe '::setup_credentials' do
  end
end
