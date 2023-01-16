module Notu

  class RecentTracks

    include Enumerable

    attr_reader :library

    def initialize(library)
      raise ArgumentError.new("#{self.class}#library must be a library, #{library.inspect} given") unless library.is_a?(Library)
      @library = library
    end

    def each
      return unless block_given?
      pages_count = nil
      page = 1
      loop do
        json = JsonDocument.get(library.url(limit: 50, method: 'user.getRecentTracks', page:))
        pages_count = json['recenttracks']['@attr']['totalPages'].to_i
        json['recenttracks']['track'].each do |track_json|
          artist = track_json['artist']['#text'] || next
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
