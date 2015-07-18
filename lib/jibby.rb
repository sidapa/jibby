Dir["#{File.dirname(__FILE__)}/jibby/**/*.rb"].each { |file| require file }

# Jibby is a console client that connects to JIRA
module Jibby
  module_function

  def start(host)
    Console.new(gateway(host)).start
  end

  def gateway(host)
    JiraGateway.new(host)
  end

  private_class_method :gateway
end
