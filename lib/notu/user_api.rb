module Notu

  class UserApi < Api

    attr_reader :username

    def initialize(username:, api_key: DEFAULT_API_KEY)
      super(api_key:)
      @username = username.try(:squish).presence || raise(Error.new('Username must be specified'))
    end

    def loved_tracks
      LovedTracks.new(self)
    end

    def recent_tracks
      RecentTracks.new(self)
    end

    def top_tracks(options = {})
      TopTracks.new(self, options)
    end

    def url(params = {})
      super((params || {}).symbolize_keys.merge(user: username))
    end

  end

end
