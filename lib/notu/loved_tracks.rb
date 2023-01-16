module Notu

  class LovedTracks

    include Enumerable

    attr_reader :user_api

    def initialize(user_api)
      raise ArgumentError.new("#{self.class}#user_api must be specified") unless user_api
      @user_api = user_api
    end

    def each
      return unless block_given?
      pages_count = nil
      page = 1
      loop do
        json = JsonDocument.get(user_api.url(limit: 50, method: 'user.getLovedTracks', page:))
        pages_count = json['lovedtracks']['@attr']['totalPages'].to_i
        json['lovedtracks']['track'].each do |track_json|
          artist = track_json['artist']['name'] || next
          title = track_json['name'] || next
          yield(Track.new(artist:, title:))
        end
        page += 1
        break if page > pages_count
      end
      nil
    end

  end

end
