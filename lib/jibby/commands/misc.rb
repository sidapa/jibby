module Jibby
  module Commands
    # Provides the exit command
    class Misc
      def self.exit(application, *_params)
        application.console.output 'bye!'
        false
      end

      def self.clear_screen(application, *_params)
        application.console.clear_screen
      end

      Jibby::CommandParser.add_command([:exit, :quit, :q], method(:exit))
      Jibby::CommandParser.add_command([:clear, :cls], method(:clear_screen))
    end
  end
end
