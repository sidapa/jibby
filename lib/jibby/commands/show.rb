module Jibby
  module Commands
    # The Load class provides the load command
    # TODO: This class needs to be smarter and not just pass attribute
    # messages and displaying those. Examples of what this class should
    # be able to do:
    # > show comments would return all comments
    # > show comments first would display first comment
    # > show comments 2 would display second comment
    class Show
      class << self
        def run(application, attribute)
          ticket = application.current_ticket
          application.interface.output output(ticket, attribute.to_sym)
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
