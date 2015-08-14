Dir["#{File.dirname(__FILE__)}/jibby/**/*.rb"].each { |file| require file }

# Jibby is a console client that connects to JIRA
module Jibby
  module_function

  attr_reader :gateway

  def interface
    @interface ||= Console.new
  end

  def application
    @application ||= Application.new
  end

  def start(host)
    @gateway = JiraGateway.new(host)
    application.start
  end
end
