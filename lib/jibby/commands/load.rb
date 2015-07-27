module Jibby
  module Commands
    # The Load class provides the load command
    class Load
      class << self
        def run(application, *params)
          console = application.console

          check_params(console: console, params: params) do |key|
            ticket = application.load_ticket(key)

            unless ticket
              console.output "#{key} was not found."
              return true
            end

            display_ticket_info(console: console, ticket: ticket)
          end

          true
        end

        private

        def check_params(console:, params:)
          if params.first
            yield params.first
          else
            console.output 'Please include a Jira Ticket number.'
          end
        end

        def display_ticket_info(console:, ticket:)
          console.output ticket.summary
          console.output ticket.description
        end
      end

      Jibby::CommandParser.add_command([:load, :open, :l, :o], method(:run))
    end
  end
end
