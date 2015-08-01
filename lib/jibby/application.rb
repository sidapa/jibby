require 'base64'
module Jibby
  # This class provides the command loop for Jibby
  class Application
    attr_reader :gateway, :interface
    attr_accessor :current_key, :current_ticket

    def initialize(gateway:, interface: Console.new)
      @gateway = gateway
      @interface = interface

      @current_key = nil
      @current_ticket = nil
    end

    def start
      return false unless gateway.credentials(interface)
      interface.clear_screen
      loop do
        parse_params = {
          input: interface.prompt(prompt_text),
          application: self
        }

        break unless Jibby::CommandParser.parse(parse_params)
      end

      true
    end

    def load_ticket(key)
      ticket_hash = @gateway.fetch_ticket(key)

      if ticket_hash
        @current_key = key
        @current_ticket = Jibby::Ticket.new(data: ticket_hash,
                                            interface: @interface)
      else
        @interface.output "#{key} was not found."
        return nil
      end
    end

    private

    def prompt_text
      "#{@current_key}>"
    end
  end
end
