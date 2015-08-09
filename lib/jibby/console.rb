require 'base64'
module Jibby
  # This class provides an interface to the user via the console
  class Console
    def initialize(interface = nil)
      @output = interface || $stdout
      @input = interface || $stdin
    end

    def clear_screen
      Gem.win_platform? ? (system 'cls') : (system 'clear')
    end

    def prompt(label)
      display_label(label)
      @input.gets.chomp
    end

    def silent_prompt(label)
      display_label(label)
      @input.noecho(&:gets).chomp
    end

    def output(text)
      @output.puts text
    end

    def prompt_login
      username = prompt 'Username:'
      password = silent_prompt 'Password:'

      [username, password]
    end

    def separator(marker = '=')
      output marker * number_of_columns
    end

    def boxed(marker = '=')
      lines = []
      yield lines
      separator(marker)
      output lines.join("\n")
      separator(marker)
    end

    private

    def display_label(label)
      "#{label} ".display
    end

    def number_of_columns
      `tput cols`.to_i
    end
  end
end
