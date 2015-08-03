module Jibby
  # Contains information about a Jira Ticket
  class Ticket
    # TODO: pass in application object instead of interface
    def initialize(data:, interface: Jibby::Console.new)
      @interface = interface
      @source = data

      attribute_map.each_pair do |k, v|
        instance_variable_set("@#{k}", fetch_value(v))
        add_attr_reader k
      end
    end

    def attributes
      @attributes ||= attribute_map.keys
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

    private

    def attribute_map
      Jibby::TicketMapper::ATTRIBUTE_MAP
    end

    def fetch_value(path)
      path.reduce(@source) do |a, e|
        a.fetch(e)
      end
    end

    def add_attr_reader(value)
      class <<self
        self
      end.class_eval do
        attr_reader value
      end
    end
  end

  # TODO: Move mapper to the application
  # This class temporarily creates an attribute map for a ticket
  class TicketMapper
    ATTRIBUTE_MAP = {
      issue_type: %w(issuetype name),
      project: %w(project name),
      assignee: %w(assignee displayName),
      status: %w(status name),
      description: %w(description),
      summary: %w(summary),
      reporter: %w(reporter displayName)
    }
  end
end
