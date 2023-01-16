module Notu

  class MostPlayedTracks

    include Enumerable

    PERIODS = %w(overall 7day 1month 3month 6month 12month).freeze

    attr_reader :library, :period

    def initialize(library, options = {})
      raise ArgumentError.new("#{self.class}#library must be a library, #{library.inspect} given") unless library.is_a?(Library)
      @library = library
      options = options.symbolize_keys.reverse_merge(period: PERIODS.first)
      self.period = options[:period]
    end

    def each
      return unless block_given?
      pages_count = nil
      page = 1
      loop do
        json = JsonDocument.get(library.url(limit: 50, method: 'user.getTopTracks', page:))
        pages_count = json['toptracks']['@attr']['totalPages'].to_i
        json['toptracks']['track'].each do |track_json|
          artist = track_json['artist']['name'] || next
          title = track_json['name'] || next
          plays_count = track_json['playcount'] || next
          yield(Track.new(artist:, plays_count:, title:))
        end
        page += 1
        break if page > pages_count
      end
      nil
    end

    private

    def period=(value)
      string_value = value.to_s
      raise ArgumentError.new("Notu::MostPlayedTracks#period is invalid: #{value.inspect}") unless PERIODS.include?(string_value)
      @period = string_value
    end

  end

end
