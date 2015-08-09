require 'spec_helper'
require 'stringio'
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
    subject(:credentials) do
      VCR.use_cassette 'jira/user' do
        new_gateway.credentials(interface)
      end
    end

    let(:interface) { Jibby::Console.new(string_io) }

    let(:string_io) { StringIO.new }
    let(:username) { 'foo' }
    let(:password) { 'bar' }

    it 'uses interface to set credentials then encodes results' do
      expect(interface).to receive(:prompt_login)
        .and_return([username, password])
      credentials
      auth_hash = new_gateway.instance_variable_get(:@authentication)
      expect(auth_hash).to eql('Zm9vOmJhcg==')
    end

    it 'returns a Jibby::User object' do
      allow(interface).to receive(:prompt_login)
        .and_return([username, password])
      expect(credentials.class).to eql(Jibby::User)
    end

    context 'invalid username or password' do
      let(:username) { 'not_foo' }
      before(:each) do
        allow(interface).to receive(:prompt_login)
          .and_return([username, password])

        allow(new_gateway).to receive(:fetch_user).and_return(nil)
      end

      it { is_expected.to eql(nil) }

      it 'displays an error and returns nil if user is not found' do
        credentials
        expect(string_io.string).to eql("\nInvalid username or password.\n")
      end
    end
  end

  describe '#fetch_ticket' do
    subject(:fetch_ticket_method) { new_gateway.fetch_ticket(key) }
    let(:http_double) { OpenStruct.new }
    let(:key) { 'FOO1' }
    let(:result_hash) { { 'foo' => 'bar' } }
    let(:request_hash) do
      { 'fields' => result_hash }
    end
    let(:response_double) { double(body: request_hash.to_json, code: code) }
    let(:code) { '200' }

    before(:each) do
      allow(Net::HTTP).to receive(:new).and_return(http_double)
      allow(http_double).to receive(:request).and_return(response_double)
    end

    it { is_expected.to eql(result_hash) }

    context 'error fetching' do
      let(:code) { 404 }

      it { is_expected.to eql(nil) }
    end
  end
end
