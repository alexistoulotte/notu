module Notu

  class MostPlayedTracks

    include Enumerable

    PERIODS = {
      'last_week' => 'week',
      'last_month' => '1month',
      'last_3_months' => '3month',
      'last_6_months' => '6month',
      'last_year' => 'year',
      'overall' => 'overall',
    }

    attr_reader :library, :period

    def initialize(library, options = {})
      raise ArgumentError.new("#{self.class}#library must be a library, #{library.inspect} given") unless library.is_a?(Library)
      @library = library
      options = options.stringify_keys.reverse_merge('period' => PERIODS.keys.first)
      self.period = options['period']
    end

    def each(&block)
      return unless block_given?
      document = HtmlDocument.get(library.url(path: 'charts', query: { 'rangetype' => PERIODS[period], 'subtype' => 'tracks' }))
      (document/'table.chart tbody tr').each do |element|
        artist = (element/'td.subjectCell a').first.text
        plays_count = (element/'td.chartbarCell a span').text.strip
        title = (element/'td.subjectCell a').last.text
        yield(Track.new(artist: artist, plays_count: plays_count, title: title))
      end
      nil
    end

    private

    def period=(value)
      raise ArgumentError.new("Notu::MostPlayedTracks#period is invalid: #{value.inspect}") unless PERIODS.key?(value.to_s)
      @period = value.to_s
    end

  end

end
