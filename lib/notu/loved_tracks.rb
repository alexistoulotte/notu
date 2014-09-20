module Notu

  class LovedTracks

    include Enumerable

    attr_reader :library

    def initialize(library)
      raise ArgumentError.new("#{self.class}#library must be a library, #{library.inspect} given") unless library.is_a?(Library)
      @library = library
    end

    def each(&block)
      return unless block_given?
      page_urls.each do |url|
        document = HtmlDocument.get(url)
        (document/'#lovedTracks td.subjectCell').each do |element|
          yield(Track.new(artist: (element/'a').first.text, title: (element/'a').last.text))
        end
      end
      nil
    end

    private

    def page_urls
      (1..pages_count).map do |index|
        library.url(path: 'library/loved', query: { 'sortBy' => 'date', 'sortOrder' => 'desc', 'page' => index })
      end
    end

    def pages_count
      document = HtmlDocument.get(library.url(path: 'library/loved'))
      [1, (document/'div.whittle-pagination a').map { |link| link.text.to_i }].flatten.max
    end

  end

end
