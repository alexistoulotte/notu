module Notu

  class Track

    include Comparable

    attr_reader :artist, :plays_count, :title

    def initialize(attributes = {})
      attributes = attributes.stringify_keys
      self.artist = attributes['artist']
      self.plays_count = attributes['plays_count']
      self.title = attributes['title']
    end

    def <=>(other)
      return nil unless other.is_a?(Track)
      result = (artist <=> other.artist)
      result.zero? ? (title <=> other.title) : result
    end

    def ==(other)
      other.is_a?(self.class) && artist == other.artist && title == other.title
    end

    def eql?(other)
      super || self == other
    end

    def to_s
      "#{artist} - #{title}"
    end

    private

    def artist=(value)
      @artist = value.to_s.squish.presence || raise(Error.new("#{self.class}#artist must be specified, #{value.inspect} given"))
    end

    def plays_count=(value)
      @plays_count = value.is_a?(Integer) || value.is_a?(String) && value =~ /\A[0-9]+\z/ ? [0, value.to_i].max : nil
    end

    def title=(value)
      @title = value.to_s.squish.presence || raise(Error.new("#{self.class}#title must be specified, #{value.inspect} given"))
    end

  end

end
