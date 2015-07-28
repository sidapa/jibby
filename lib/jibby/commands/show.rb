module Jibby
  module Commands
    # The Load class provides the load command
    class Show
      class << self
        def run(application, attribute)
          ticket = application.current_ticket
          application.console.output output(ticket, attribute.to_sym)
          true
        end

        private

        def output(ticket, attribute)
          return 'Please load a ticket first.' unless ticket
          return ticket.send(attribute) if ticket.attributes.include? attribute

          'Invalid attribute'
        end
     end

      Jibby::CommandParser.add_command([:show, :s], method(:run))
    end
  end
end
