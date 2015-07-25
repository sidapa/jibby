module Jibby
  module Commands
    # Provides the exit command
    class Exit
      def self.run(application, *_params)
        application.console.output 'bye!'
        false
      end

      Jibby::CommandParser.add_command([:exit, :quit, :q], method(:run))
    end
  end
end
