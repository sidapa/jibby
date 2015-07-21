require 'base64'
module Jibby
  # This class provides the command loop for Jibby
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

    private

    def display_label(label)
      "#{label} ".display
    end
  end
end
