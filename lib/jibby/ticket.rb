module Jibby
  class Ticket
    attr_reader :issue_type, :project, :assignee
    attr_reader :status, :description, :summary, :reporter
    def initialize(input_hash)
      @issue_type = input_hash['issuetype']['name']
      @project = input_hash['project']['name']
      @assignee = input_hash['assignee']['displayName']
      @status = input_hash['status']['name']
      @description = input_hash['description']
      @summary = input_hash['summary']
      @reporter = input_hash['reporter']['displayName']
    end
  end
end
