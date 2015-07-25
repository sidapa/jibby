module Jibby
  module Commands
    # The Load class provides the load command
    class Load
      def self.run(application, *params)
        key = params.first
        ticket = application.load_ticket(key)
        console = application.console

        unless ticket
          console.output "#{key} was not found."
          return true
        end

        console.output ticket.summary

        true
      end

      Jibby::CommandParser.add_command([:load, :open, :l, :o], method(:run))
    end
  end
end
