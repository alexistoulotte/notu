module Notu

  module Listing

    include Enumerable

    attr_reader :library

    def initialize(library)
      raise ArgumentError.new("#{self.class}#library must be a library, #{library.inspect} given") unless library.is_a?(Library)
      @library = library
    end

    def page_urls
      (1..pages_count).map do |index|
        library.url(path:, query: params.merge('page' => index))
      end
    end

    def pages_count
      document = HtmlDocument.get(library.url(path:, query: params))
      [1, (document / 'ul.pagination-list li.pagination-page').text.split(/\s+/).map(&:to_i)].flatten.compact.max
    end

    def params
      # to be overriden
      {}
    end

  end

end
