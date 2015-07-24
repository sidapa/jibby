module Jibby
  module Commands
    class Load
      def self.run(application, *params)
        ticket_key = params.first
        result_hash = application.load_ticket(ticket_key)

        if result_hash
          current_ticket = Jibby::Ticket.new(result_hash)

          application.current_ticket = current_ticket
          application.current_key = ticket_key

          puts current_ticket.summary
        else
          puts '#{ticket_key} not found.'
        end

        true
      end

      Jibby::CommandParser.add_command([:load, :open, :l, :o], self.method(:run))
    end
  end
end

