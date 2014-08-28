module Notu

  class Track

    attr_reader :artist, :plays_count, :title

    def initialize(attributes = {})
      attributes = attributes.stringify_keys
      self.artist = attributes['artist']
      self.plays_count = attributes['plays_count']
      self.title = attributes['title']
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
