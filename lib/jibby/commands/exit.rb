module Jibby
  module Commands
    class Exit
      def self.run(application, *_params)
        application.console.output 'bye!'
        false
      end

      Jibby::CommandParser.add_command([:exit, :quit, :q], self.method(:run))
    end
  end
end
