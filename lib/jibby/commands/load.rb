module Jibby
  module Commands
    class Load
      def self.run(application, *params)
        ticket_key = params.first
        result_hash = application.load_ticket(ticket_key)
        console = application.console

        if result_hash
          application.current_ticket = Jibby::Ticket.new(result_hash)
          application.current_key = ticket_key

          console.output application.current_ticket.summary
        else
          console.output '#{ticket_key} not found.'
        end

        true
      end

      Jibby::CommandParser.add_command([:load, :open, :l, :o], self.method(:run))
    end
  end
end

