module Jibby
  module Commands
    # Provides the exit command
    class Misc
      def self.exit(application, *_params)
        application.console.output 'bye!'
        false
      end

      Jibby::CommandParser.add_command([:exit, :quit, :q], method(:exit))
    end
  end
end
