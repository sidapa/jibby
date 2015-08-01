require 'base64'
module Jibby
  # This class provides an interface to the user via the console
  class Console
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

    def output(text)
      puts text
    end

    def prompt_login
      output "Login to #{@host}"
      username = prompt 'Username:'
      password = silent_prompt 'Password:'

      [username, password]
    end

    private

    def display_label(label)
      "#{label} ".display
    end
  end
end
