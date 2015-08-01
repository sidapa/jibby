require 'net/http'
require 'net/https'
require 'json'

module Jibby
  # This class provides Jibby access to a JIRA host
  class JiraGateway
    API_PATH = '/rest/api/2'

    def initialize(host)
      @host = URI.parse(host)
    end

    def credentials(interface)
      interface.output "Login to #{@host}"
      username = interface.prompt 'Username:'
      password = interface.silent_prompt 'Password:'

      return unless username && password

      @authentication = Base64.strict_encode64("#{username}:#{password}")
    end

    def fetch_ticket(key)
      path = "#{API_PATH}/issue/#{key}"
      req = Net::HTTP::Get.new(path)
      req['Authorization'] = "Basic #{@authentication}" if @authentication
      response = http_object.request(req)

      return nil unless response.code.to_i == 200

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
