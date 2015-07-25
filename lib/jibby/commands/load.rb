module Jibby
  module Commands
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

      Jibby::CommandParser.add_command([:load, :open, :l, :o], self.method(:run))
    end
  end
end

