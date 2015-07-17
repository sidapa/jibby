module Jibby
  # This class provides the command loop for Jibby
  module Console
    module_function

    def start
      loop do
        display_prompt
        break unless parse(gets.chomp)
      end
    end

    def display_prompt
      '>'.display
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
