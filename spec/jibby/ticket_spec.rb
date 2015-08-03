require 'spec_helper'

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

  let(:interface) { Jibby::Console.new }

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

    it { is_expected.to eql(Jibby::TicketMapper::ATTRIBUTE_MAP.keys) }
  end

  describe '#display_detais' do
    subject(:display_details) { ticket.display_details }

    it 'shows information via the interface' do
      expect(interface).to receive(:output).at_least(:once)
      expect(interface).to receive(:separator).at_least(:once)

      display_details
    end
  end
end
