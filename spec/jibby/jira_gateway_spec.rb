require 'spec_helper'
require 'ostruct'

describe Jibby::JiraGateway do
  subject(:new_gateway) { Jibby::JiraGateway.new(host) }
  let(:host) { 'http://foo.bar' }

  describe '::initialize' do
    let(:parsed_host) { URI.parse(host) }

    it 'uses URI to parse the gateway' do
      expect(URI).to receive(:parse).with(host)
      new_gateway
    end

    it 'sets the parsed host to the @host variable' do
      expect(new_gateway.instance_variable_get(:@host)).to eql(parsed_host)
    end
  end

  describe '#credentials' do
    subject(:credentials) { new_gateway.credentials(console) }

    let(:console) { Jibby::Console.new }
    let(:username) { 'foo' }
    let(:password) { 'bar' }

    it 'uses console to set credentials then encodes results' do
      expect(console).to receive(:prompt).with('Username:')
        .and_return(username)
      expect(console).to receive(:silent_prompt).with('Password:')
        .and_return(password)
      expect(credentials).to eql('Zm9vOmJhcg==')
    end
  end

  describe '#load_ticket' do

    subject(:load_ticket_method) { new_gateway.load_ticket(key) }
    let(:http_double) { OpenStruct.new }
    let(:key) { 'FOO1' }
    let(:result_hash) { { 'foo' => 'bar' } }
    let(:request_hash) do
      { 'fields' => result_hash }
    end
    let(:response_double) { double(body: request_hash.to_json) }

    before(:each) do
      allow(Net::HTTP).to receive(:new).and_return(http_double)
      allow(http_double).to receive(:request).and_return(response_double)
    end

    it { is_expected.to eql(result_hash) }
  end
end
