module Notu

  class UnknownUsernameError < Error

    attr_reader :username

    def initialize(username)
      @username = username
      super("No such Last.fm username: #{self.username.inspect}")
    end

  end

end
