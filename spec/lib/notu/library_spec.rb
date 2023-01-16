require 'spec_helper'

describe Notu::Library, :vcr do

  let(:library) { Notu::Library.new(username: 'alexistoulotte') }

  describe '#api' do

    it 'has a default value' do
      expect(Notu::Library.new(username: 'John').api.key).to eq('91f5d6a201de58e0c0a0d858573dddf0')
    end

    it 'can be specified' do
      expect(Notu::Library.new(api: Notu::Api.new(key: '424243'), username: 'john').api.key).to eq('424243')
    end

    it 'must be specified' do
      expect {
        Notu::Library.new(api: nil, username: 'john')
      }.to raise_error('API must be specified')
    end

  end

  describe '#loved_tracks' do

    it 'returns a LovedTracks object' do
      expect(library.loved_tracks).to be_a(Notu::LovedTracks)
    end

  end

  describe '#most_played_tracks' do

    it 'returns a LovedTracks object' do
      most_played_tracks = library.most_played_tracks
      expect(most_played_tracks).to be_a(Notu::MostPlayedTracks)
      expect(most_played_tracks.period).to eq('overall')
    end

    it 'accepts options' do
      expect(library.most_played_tracks(period: '1month').period).to eq('1month')
    end

  end

  describe '#recent_tracks' do

    it 'returns a RecentTracks object' do
      expect(library.recent_tracks).to be_a(Notu::RecentTracks)
    end

  end

  describe '#username' do

    it 'is username set at initialization' do
      expect(library.username).to eq('alexistoulotte')
    end

    it 'can be specified as symbol' do
      expect(Notu::Library.new(username: 'john42').username).to eq('john42')
    end

    it 'raise an error if nil' do
      expect {
        Notu::Library.new(username: nil)
      }.to raise_error(Notu::Error, 'Username must be specified')
    end

    it 'raise an error if blank' do
      expect {
        Notu::Library.new(username: ' ')
      }.to raise_error(Notu::Error, 'Username must be specified')
    end

  end

  describe '#url' do

    it 'returns default url' do
      expect(library.url).to eq('https://ws.audioscrobbler.com/2.0?user=alexistoulotte&api_key=91f5d6a201de58e0c0a0d858573dddf0&format=json')
    end

    it 'accepts query parameters' do
      expect(library.url(bar: 42, 'baz' => 'hello&world')).to eq('https://ws.audioscrobbler.com/2.0?bar=42&baz=hello%26world&user=alexistoulotte&api_key=91f5d6a201de58e0c0a0d858573dddf0&format=json')
    end

  end

end
