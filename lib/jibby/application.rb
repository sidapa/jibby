require 'base64'
module Jibby
  # This class provides the command loop for Jibby
  class Application
    attr_reader :gateway, :console

    def initialize(gateway:, console:)
      @gateway = gateway
      @console = console
    end

    def start
      return false unless gateway.credentials(console)
      loop { break unless parse(console.prompt(prompt_text)) }
    end

    private

    def prompt_text
      '>'
    end

    def parse(input)
      command, *params = input.split(' ')
      return false if command == 'exit'
      case command
      when 'load'
      else
        puts [command, params].join(' ')
      end
      true
    end
  end
end
