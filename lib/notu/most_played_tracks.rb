module Notu

  class MostPlayedTracks

    include Listing

    PERIODS = {
      '7 days' => 'LAST_7_DAYS',
      '30 days' => 'LAST_30_DAYS',
      '90 days' => 'LAST_90_DAYS',
      '365 days' => 'LAST_365_DAYS',
      'Overall' => '',
    }.freeze

    attr_reader :period

    def initialize(library, options = {})
      super(library)
      options = options.stringify_keys.reverse_merge('period' => PERIODS.keys.first)
      self.period = options['period']
    end

    def each
      return unless block_given?
      page_urls.each do |url|
        document = HtmlDocument.get(url)
        (document / 'table.chartlist tbody tr').each do |element|
          artist = (element / 'td.chartlist-artist a').first.try(:text) || next
          title = (element / 'td.chartlist-name a').first.try(:text) || next
          plays_count = (element / 'td.chartlist-bar .chartlist-count-bar-value').text.gsub(/[^\d]/, '').presence || next
          yield(Track.new(artist:, plays_count:, title:))
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
