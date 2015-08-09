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
      username, password = *interface.prompt_login

      return false unless username && password

      @authentication = Base64.strict_encode64("#{username}:#{password}")
      user = fetch_user(username)
      return Jibby::User.new(data: user) if user
      interface.output "\nInvalid username or password."
      nil
    end

    def fetch_ticket(key)
      path = "#{API_PATH}/issue/#{key}"

      response = get(path)
      return nil unless response.code.to_i == 200

      JSON.parse(response.body)['fields']
    end

    private

    def fetch_user(username)
      path = "#{API_PATH}/user?username=#{username}"
      response = get(path)

      return nil unless response.code.to_i == 200

      JSON.parse(response.body)
    end

    def get(path)
      req = Net::HTTP::Get.new(path)
      req['Authorization'] = "Basic #{@authentication}" if @authentication
      http_object.request(req)
    end

    def http_object
      @http ||= Net::HTTP.new(@host.host, @host.port).tap do |http|
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end
  end
end
