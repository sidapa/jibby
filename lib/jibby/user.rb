module Jibby
  # Contains information about a Jira User
  class User
    attr_reader :username, :fullname, :timezone

    def initialize(data:)
      @username = data['key']
      @fullname = data['displayName']
      @timezone = data['timeZone']
      @active = data['active']
    end

    def active?
      @active
    end
  end
end
