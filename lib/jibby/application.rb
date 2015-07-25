require 'base64'
module Jibby
  # This class provides the command loop for Jibby
  class Application
    attr_reader :gateway, :console
    attr_accessor :current_key, :current_ticket

    def initialize(gateway:, console:)
      @gateway = gateway
      @console = console

      @current_key = nil
      @current_ticket = nil
    end

    def start
      return false unless gateway.credentials(console)
      console.clear_screen
      loop do
        parse_params = {
          input: console.prompt(prompt_text),
          application: self
        }

        break unless Jibby::CommandParser.parse(parse_params)
      end

      true
    end

    def load_ticket(key)
      ticket_hash = @gateway.fetch_ticket(key)

      return nil unless ticket_hash

      @current_key = key
      @current_ticket = Jibby::Ticket.new(ticket_hash)
    end

    private

    def prompt_text
      "#{@current_key}>"
    end
  end
end
