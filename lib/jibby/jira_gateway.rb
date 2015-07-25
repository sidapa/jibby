require 'net/http'
require 'net/https'
require 'json'

module Jibby
  # This class provides Jibby access to a JIRA host
  class JiraGateway
    API_PATH = "/rest/api/2"

    def initialize(host)
      @host = URI.parse(host)
    end

    def credentials(console)
      console.output "Login to #{@host}"
      username = console.prompt 'Username:'
      password = console.silent_prompt 'Password:'

      @authentication = Base64.strict_encode64("#{username}:#{password}")
    end

    def load_ticket(key)
      path = "#{API_PATH}/issue/#{key}"
      req = Net::HTTP::Get.new(path)
      req['Authorization'] = "Basic #{@authentication}"
      response = http_object.request(req)
      JSON.parse(response.body)['fields']
    end

    private

    def http_object
      @http ||= Net::HTTP.new(@host.host, @host.port).tap do |h|
        h.use_ssl = true
        h.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end
  end
end
