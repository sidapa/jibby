module Jibby
  class CommandParser
    @commands = {}

    def self.add_command(keys, method)
      fail ArgumentError unless method.class == Method
      Array(keys).each do |key|
        fail ArgumentError unless [String, Symbol].include? key.class
        @commands[key.to_sym] = method
      end
    end

    def self.parse(application:, input:)
      command, *params = input.split(' ')
      console = application.console

      if @commands.keys.include? command.to_sym
        @commands[command.to_sym].call(application, *params)
      else
        console.output 'Command not found.'
        return true
      end
    end
  end
end
