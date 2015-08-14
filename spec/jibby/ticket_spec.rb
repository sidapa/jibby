require 'spec_helper'
require 'stringio'

describe Jibby::Ticket, :vcr do
  subject(:ticket) do
    Jibby::Ticket.new(data: result_hash, interface: interface)
  end

  let(:result_hash) do
    result = nil
    VCR.use_cassette 'jira/ticket' do
      gateway = Jibby::JiraGateway.new('https://jira.foo.com')
      result = gateway.fetch_ticket(ticket_name)
    end
    return result
  end

  let(:ticket_name) { 'FOO-1' }

  let(:interface) { Jibby::Console.new(string_io) }
  let(:string_io) { StringIO.new }

  it 'should set the correct accessible variables' do
    expect(ticket.issue_type).to eql('Feature')
    expect(ticket.project).to eql('FOO Project')
    expect(ticket.assignee).to eql('Assigned User')
    expect(ticket.status).to eql('Resolved')
    expect(ticket.reporter).to eql('Reporter User')
    expect(ticket.description).to eql('This is a sample description')
    expect(ticket.summary).to eql('Foo Summary')
  end

  describe '#attributes' do
    subject(:attributes) { ticket.attributes }
    let(:full_keys) do
      Jibby::TicketMapper::ATTRIBUTE_MAP.keys + [:comments]
    end

    it { is_expected.to eql(full_keys) }
  end

  describe '#display_details' do
    subject(:display_details) { ticket.display_details }

    it 'shows information via the interface' do
      expect(interface).to receive(:output).at_least(:once)
      expect(interface).to receive(:separator).at_least(:once)

      display_details
    end
  end

  describe '#comments' do
    subject(:comments_method) { ticket.comments }

    before(:each) do
      Jibby.instance_variable_set(:@interface, Jibby::Console.new(string_io))
    end

    after(:each) do
      Jibby.instance_variable_set(:@interface, Jibby::Console.new)
    end

    it { is_expected.to be_nil }

    it 'displays comment details' do
      expect(string_io.string).to eql('')
    end

    context 'No comments' do
      before(:each) { ticket.instance_variable_set(:@comments, []) }
      it { is_expected.to eql('Ticket has no comments.') }
    end
  end
end
