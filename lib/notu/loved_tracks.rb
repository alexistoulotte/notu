module Notu

  class LovedTracks

    include Listing

    def each(&block)
      return unless block_given?
      page_urls.each do |url|
        document = HtmlDocument.get(url)
        (document/'table.chartlist tbody tr').each do |element|
          artist = (element/'td.chartlist-artist a').first.try(:text) || next
          title = (element/'td.chartlist-name a').first.try(:text) || next
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
