module Jibby
  # Contains information about a Jira Ticket
  class Ticket
    attr_reader :issue_type, :project, :assignee
    attr_reader :status, :description, :summary, :reporter

    AVAILABLE_ATTRIBUTES = [:issue_type,
                            :project,
                            :assignee,
                            :status,
                            :description,
                            :summary,
                            :reporter]

    # TODO: Fix initialize method
    # rubocop:disable Metrics/AbcSize
    def initialize(data:, interface: Jibby::Console.new)
      @interface = interface
      @issue_type = data['issuetype']['name']
      @project = data['project']['name']
      @assignee = data['assignee']['displayName']
      @status = data['status']['name']
      @description = data['description']
      @summary = data['summary']
      @reporter = data['reporter']['displayName']
    end

    def attributes
      AVAILABLE_ATTRIBUTES
    end

    def display_details
      @interface.boxed do |lines|
        lines << @summary
        lines << "Assigned to: #{@assignee}"
        lines << "Reported by: #{@reporter}"
      end

      @interface.output @description
      @interface.separator('-')
    end
  end
end
