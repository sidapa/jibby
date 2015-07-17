Dir["#{File.dirname(__FILE__)}/jibby/**/*.rb"].each { |file| require file }

# Jibby is a console client that connects to JIRA
module Jibby
  def self.start
    Console.start
  end
end
