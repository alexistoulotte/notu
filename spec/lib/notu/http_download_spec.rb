require 'spec_helper'

describe Notu::HttpDownload, :vcr do

  describe '.get' do

    it 'retrives document from given URL' do
      expect(Notu::HttpDownload.get('http://alweb.org')).to include('<title>Alexis Toulotte</title>')
    end

    it 'accepts HTTPS URL' do
      expect(Notu::HttpDownload.get('https://alweb.org')).to include('<title>Alexis Toulotte</title>')
    end

    it 'follow redirects' do
      expect(Notu::HttpDownload.get('http://www.alweb.org')).to include('<title>Alexis Toulotte</title>')
    end

    it 'raise an error if an invalid URL is given' do
      expect {
        Notu::HttpDownload.get('ftp://www.alweb.org')
      }.to raise_error(Notu::NetworkError, 'Invalid URL: "ftp://www.alweb.org"')
    end

    it 'raise a NetworkError on 404' do
      expect {
        Notu::HttpDownload.get('http://alweb.org/foo', max_retries: 0)
      }.to raise_error(Notu::NetworkError, '404 "Not Found"')
    end

    it 'raise a NetworkError if too many redirects' do
      expect {
        Notu::HttpDownload.get('http://www.alweb.org', max_redirects: 0, max_retries: 0)
      }.to raise_error(Notu::NetworkError, 'Max redirects has been reached')
    end

  end

end
