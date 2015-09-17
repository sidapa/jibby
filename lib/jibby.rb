Dir["#{File.dirname(__FILE__)}/jibby/**/*.rb"].each { |file| require file }

# Jibby is a console client that connects to JIRA
module Jibby
  class << self
    attr_reader :gateway
  end

  module_function

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
