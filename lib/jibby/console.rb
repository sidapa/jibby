require 'base64'
module Jibby
  # This class provides the command loop for Jibby
  class Console
    def initialize(jira_host)
      @authentication = ''
      @host = jira_host
    end

    def start
      setup_credentials
      loop do
        display_prompt
        break unless parse($stdin.gets.chomp)
      end
    end

    private

    def setup_credentials
      puts "Login to #{@host}"
      'Username: '.display
      username = $stdin.gets.chomp
      'Password: '.display
      password = $stdin.noecho(&:gets).chomp

      @authentication = Base64.strict_encode64("#{username}:#{password}")
      Gem.win_platform? ? (system 'cls') : (system 'clear')
    end

    def display_prompt
      '> '.display
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
