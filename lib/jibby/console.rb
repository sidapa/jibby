require 'base64'
module Jibby
  # This class provides the command loop for Jibby
  class Console
    attr_reader :gateway

    def initialize(gateway)
      @gateway = gateway
    end

    def start
      return false unless gateway.credentials(self)
      loop { break unless parse(prompt(prompt_text)) }
    end

    def clear_screen
      Gem.win_platform? ? (system 'cls') : (system 'clear')
    end

    def prompt(label)
      display_label(label)
      $stdin.gets.chomp
    end

    def silent_prompt(label)
      display_label(label)
      $stdin.noecho(&:gets).chomp
    end

    private

    def prompt_text
      '>'
    end

    def display_label(label)
      "#{label} ".display
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
