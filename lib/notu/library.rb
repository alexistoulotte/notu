module Notu

  class Library

    HOST = 'www.last.fm'.freeze

    attr_reader :username

    def initialize(options = {})
      @semaphore = Mutex.new
      options = options.symbolize_keys
      self.username = options[:username]
    end

    def loved_tracks
      LovedTracks.new(self)
    end

    def most_played_tracks(options = {})
      MostPlayedTracks.new(self, options)
    end

    def played_tracks
      PlayedTracks.new(self)
    end

    def url(options = {})
      options = options.symbolize_keys
      path = options[:path].presence
      query = options[:query].presence
      query = options[:query].map { |name, value| "#{CGI.escape(name.to_s)}=#{CGI.escape(value.to_s)}" }.join('&') if options[:query].is_a?(Hash)
      "https://#{HOST}/user/#{username}".tap do |url|
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

    def username=(value)
      @semaphore.synchronize do
        @username = value.to_s.strip.downcase
        raise UnknownUsernameError.new(value) if username !~ /^[a-z0-9_]+$/
        begin
          HtmlDocument.get(url)
        rescue
          raise UnknownUsernameError.new(value)
        end
      end
    end

  end

end
