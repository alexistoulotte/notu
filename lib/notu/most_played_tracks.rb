module Notu

  class MostPlayedTracks

    include Enumerable
    include Listing

    PERIODS = {
      '7 days' => 'LAST_7_DAYS',
      '30 days' => 'LAST_30_DAYS',
      '90 days' => 'LAST_90_DAYS',
      '365 days' => 'LAST_365_DAYS',
      'Overall' => '',
    }

    attr_reader :period

    def initialize(library, options = {})
      super(library)
      options = options.stringify_keys.reverse_merge('period' => PERIODS.keys.first)
      self.period = options['period']
    end

    def each(&block)
      return unless block_given?
      page_urls.each do |url|
        document = HtmlDocument.get(url)
        (document/'table.chartlist tbody tr').each do |element|
          artist = (element/'td.chartlist-name .chartlist-artists').first.text
          title = (element/'td.chartlist-name .link-block-target').first.text
          plays_count = (element/'td.chartlist-countbar .countbar-bar-value').text.gsub(/[^\d]/, '')
          yield(Track.new(artist: artist, plays_count: plays_count, title: title))
        end
      end
      nil
    end

    def params
      { 'date_preset' => PERIODS[period] }
    end

    def path
      'library/tracks'
    end

    private

    def period=(value)
      raise ArgumentError.new("Notu::MostPlayedTracks#period is invalid: #{value.inspect}") unless PERIODS.key?(value.to_s)
      @period = value.to_s
    end

  end

end
