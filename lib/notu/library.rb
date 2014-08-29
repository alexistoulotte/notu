module Notu

  class Library

    DEFAULT_HOST = 'www.last.fm'

    attr_reader :host, :username

    def initialize(options = {})
      options = options.stringify_keys
      self.host = options['host']
      self.username = options['username']
    end

    def loved_tracks
      @loved_tracks ||= LovedTracks.new(self)
    end

    def most_played_tracks(options = {})
      MostPlayedTracks.new(self, options)
    end

    def url(options = {})
      options = options.stringify_keys
      path = options['path'].presence
      query = options['query'].presence
      query = options['query'].map { |name, value| "#{CGI.escape(name.to_s)}=#{CGI.escape(value.to_s)}" }.join('&') if options['query'].is_a?(Hash)
      "http://#{host}/user/#{username}".tap do |url|
        if path.present?
          url << '/' unless path.starts_with?('/')
          url << path
        end
        if query.present?
          url << '?' << query
        end
      end
    end

    private

    def host=(value)
      @host = value.presence || DEFAULT_HOST
    end

    def username=(value)
      @username = value.to_s.strip.downcase
      raise Error.new("Invalid Last.fm username: #{value.inspect}") if username !~ /^[a-z0-9_]+$/
    end

  end

end
