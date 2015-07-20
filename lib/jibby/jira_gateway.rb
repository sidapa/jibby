require 'net/http'
require 'net/https'

module Jibby
  # This class provides Jibby access to a JIRA host
  class JiraGateway
    def initialize(host)
      @host = URI.parse(host)
    end

    def credentials(console)
      puts "Login to #{@host}"
      username = console.prompt 'Username:'
      password = console.silent_prompt 'Password:'

      @authentication = Base64.strict_encode64("#{username}:#{password}")
    end
  end
end
