require 'spec_helper'

describe Notu::Api do

  describe '#api_key' do

    it 'has a default value' do
      expect(Notu::Api.new.api_key).to eq('91f5d6a201de58e0c0a0d858573dddf0')
    end

    it 'can be specified' do
      expect(Notu::Api.new(api_key: '430249320204').api_key).to eq('430249320204')
    end

    it 'raise an error if blank' do
      expect {
        Notu::Api.new(api_key: ' ')
      }.to raise_error('API key must be specified')
    end

  end

  describe '#url' do

    it 'returns default url' do
      expect(Notu::Api.new.url).to eq('https://ws.audioscrobbler.com/2.0?api_key=91f5d6a201de58e0c0a0d858573dddf0&format=json')
    end

    it 'accepts query parameters' do
      expect(Notu::Api.new.url(bar: 42, 'baz' => 'hello&world')).to eq('https://ws.audioscrobbler.com/2.0?bar=42&baz=hello%26world&api_key=91f5d6a201de58e0c0a0d858573dddf0&format=json')
    end

  end

end
