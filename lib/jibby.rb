Dir["#{File.dirname(__FILE__)}/jibby/**/*.rb"].each { |file| require file }

# Jibby is a console client that connects to JIRA
module Jibby
  module_function

  def start(host)
    gateway = JiraGateway.new(host)
    Application.new(gateway: gateway).start
  end
end
