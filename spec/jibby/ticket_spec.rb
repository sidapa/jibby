require 'spec_helper'

describe Jibby::Ticket do
  subject(:ticket) { Jibby::Ticket.new(result_hash) }
  let(:result_hash) do
    {
      'issuetype' => { 'name' => issuetype_name },
      'project' => { 'name' => project_name },
      'assignee' => { 'displayName' => assignee_name },
      'status' => { 'name' => status_name },
      'description' => description,
      'summary' => summary,
      'reporter' => { 'displayName' => reporter_name }
    }
  end

  let(:issuetype_name) { 'Issue Name' }
  let(:project_name) { 'Test Project' }
  let(:assignee_name) { 'Test Assignee' }
  let(:status_name) { 'Status Name' }
  let(:description) { 'Test Description' }
  let(:summary) { 'Test Summary' }
  let(:reporter_name) { 'Test Reporter' }

  it 'should set the correct accessible variables' do
    expect(ticket.issue_type).to eql(issuetype_name)
    expect(ticket.project).to eql(project_name)
    expect(ticket.assignee).to eql(assignee_name)
    expect(ticket.status).to eql(status_name)
    expect(ticket.description).to eql(description)
    expect(ticket.summary).to eql(summary)
    expect(ticket.reporter).to eql(reporter_name)
  end
end
