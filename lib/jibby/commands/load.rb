module Jibby
  module Commands
    # The Load class provides the load command
    class Load
      class << self
        def run(application, *params)
          interface = application.interface

          check_params(interface: interface, params: params) do |key|
            ticket = application.load_ticket(key)

            return true unless ticket

            ticket.display_details
          end

          true
        end

        private

        def check_params(interface:, params:)
          if params.first
            yield params.first
          else
            interface.output 'Please include a Jira Ticket number.'
          end
        end
      end

      Jibby::CommandParser.add_command([:load, :open, :l, :o], method(:run))
    end
  end
end
