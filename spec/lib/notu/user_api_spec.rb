require 'spec_helper'

describe Notu::UserApi, :vcr do

  let(:user_api) { Notu::UserApi.new(username: 'alexistoulotte') }

  describe '#api_key' do

    it 'has a default value' do
      expect(Notu::UserApi.new(username: 'John').api_key).to eq('91f5d6a201de58e0c0a0d858573dddf0')
    end

    it 'can be specified' do
      expect(Notu::UserApi.new(api_key: '424243', username: 'john').api_key).to eq('424243')
    end

    it 'must be specified' do
      expect {
        Notu::UserApi.new(api_key: nil, username: 'john')
      }.to raise_error('API key must be specified')
    end

  end

  describe '#loved_tracks' do

    it 'returns a LovedTracks object' do
      expect(user_api.loved_tracks).to be_a(Notu::LovedTracks)
    end

  end

  describe '#recent_tracks' do

    it 'returns a RecentTracks object' do
      expect(user_api.recent_tracks).to be_a(Notu::RecentTracks)
    end

  end

  describe '#top_tracks' do

    it 'returns a LovedTracks object' do
      top_tracks = user_api.top_tracks
      expect(top_tracks).to be_a(Notu::TopTracks)
      expect(top_tracks.period).to eq('overall')
    end

    it 'accepts options' do
      expect(user_api.top_tracks(period: '1month').period).to eq('1month')
    end

  end

  describe '#username' do

    it 'is username set at initialization' do
      expect(user_api.username).to eq('alexistoulotte')
    end

    it 'can be specified as symbol' do
      expect(Notu::UserApi.new(username: 'john42').username).to eq('john42')
    end

    it 'raise an error if nil' do
      expect {
        Notu::UserApi.new(username: nil)
      }.to raise_error(Notu::Error, 'Username must be specified')
    end

    it 'raise an error if blank' do
      expect {
        Notu::UserApi.new(username: ' ')
      }.to raise_error(Notu::Error, 'Username must be specified')
    end

  end

  describe '#url' do

    it 'returns default url' do
      expect(user_api.url).to eq('https://ws.audioscrobbler.com/2.0?user=alexistoulotte&api_key=91f5d6a201de58e0c0a0d858573dddf0&format=json')
    end

    it 'accepts query parameters' do
      expect(user_api.url(bar: 42, 'baz' => 'hello&world')).to eq('https://ws.audioscrobbler.com/2.0?bar=42&baz=hello%26world&user=alexistoulotte&api_key=91f5d6a201de58e0c0a0d858573dddf0&format=json')
    end

  end

end
