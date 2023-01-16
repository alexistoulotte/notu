module Notu

  class Library

    attr_reader :api, :username

    def initialize(username:, api: Api.new)
      @api = api.presence || raise(Error.new('API must be specified'))
      @username = username.try(:squish).presence || raise(Error.new('Username must be specified'))
    end

    def loved_tracks
      LovedTracks.new(self)
    end

    def most_played_tracks(options = {})
      MostPlayedTracks.new(self, options)
    end

    def recent_tracks
      RecentTracks.new(self)
    end

    def url(params = {})
      api.url((params || {}).symbolize_keys.merge(user: username))
    end

  end

end
