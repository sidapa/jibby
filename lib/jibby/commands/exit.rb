module Jibby
  module Commands
    class Exit
      def self.run(*_params)
        puts 'bye!'
        false
      end

      Jibby::CommandParser.add_command([:exit, :quit, :q], self.method(:run))
    end
  end
end
