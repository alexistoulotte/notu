require 'spec_helper'

describe Notu::HtmlDocument, :vcr do

  describe '.get' do

    it 'returns document parsed' do
      document = Notu::HtmlDocument.get('http://alweb.org')
      expect((document/'title').text).to eq('Alexis Toulotte')
    end

    it 'follows redirects' do
      document = Notu::HtmlDocument.get('http://www.alweb.org')
      expect((document/'title').text).to eq('Alexis Toulotte')
    end

    it 'raise a NetworkError on 404' do
      expect {
        Notu::HtmlDocument.get('http://alweb.org/foo')
      }.to raise_error(Notu::NetworkError, '404 "Not Found"')
    end

    it 'raise a ParseError if not a valid document' do
      expect {
        Notu::HtmlDocument.get('http://alweb.org/avatar')
      }.to raise_error(Notu::ParseError, 'Invalid HTML document')
    end

  end

end
