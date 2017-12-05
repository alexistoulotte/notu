module Notu

  module HtmlDocument

    def self.get(url, options = {})
      parse(HttpDownload.get(url, options))
    end

    def self.parse(data)
      data = data.gsub(/&nbsp;/i, ' ').gsub(/\s+/, ' ')
      document = Nokogiri::HTML.parse(data, nil, 'UTF-8')
      raise ParseError.new('Invalid HTML document') if (document/'head').empty?
      document
    end
    private_class_method :parse

  end

end
