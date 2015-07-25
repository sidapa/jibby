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
      loop { break unless Jibby::CommandParser.parse(input: console.prompt(prompt_text), application: self) }
      true
    end

    def load_ticket(*params)
      @gateway.load_ticket(*params)
    end

    private

    def prompt_text
      "#{@current_key}>"
    end
  end
end
