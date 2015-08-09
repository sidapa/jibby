module Jibby
  # Contains information about a comment on a Jira Ticket
  class Comment
    def initialize(data:, interface:)
      @interface = interface
      @index = data['jibby_index']
      @author = data['author']['displayName']
      @body = data['body']
    end

    def display_details
      @interface.output ''

      @interface.boxed do |lines|
        lines << "Comment ##{@index + 1} Author: #{@author}"
      end

      @interface.output @body
    end
  end
end
