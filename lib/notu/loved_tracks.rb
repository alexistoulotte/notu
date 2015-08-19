module Notu

  class LovedTracks

    include Enumerable
    include Listing

    def each(&block)
      return unless block_given?
      page_urls.each do |url|
        document = HtmlDocument.get(url)
        (document/'#user-loved-tracks-section tbody tr').each do |element|
          artist = (element/'td.chartlist-name .link-block-target').first.text
          title = (element/'td.chartlist-name .chartlist-artists').first.text
          yield(Track.new(artist: artist, title: title))
        end
      end
      nil
    end

    def path
      'loved'
    end

  end

end
