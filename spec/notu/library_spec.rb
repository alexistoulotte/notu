require 'spec_helper'

describe Notu::Library do

  let(:library) { Notu::Library.new(username: 'alexistoulotte') }

  describe '#host' do

    it 'is "www.last.fm" by default' do
      expect(library.host).to eq('www.last.fm')
    end

    it 'can be specified via option' do
      expect(Notu::Library.new(host: 'www.lastfm.fr', username: 'alex').host).to eq('www.lastfm.fr')
    end

    it 'can be specified via option (as string)' do
      expect(Notu::Library.new('host' => 'www.lastfm.fr', username: 'alex').host).to eq('www.lastfm.fr')
    end

    it 'is default host if blank' do
      expect(Notu::Library.new(host: ' ', username: 'alex').host).to eq('www.last.fm')
    end

  end

  describe '#loved_tracks' do

    it 'returns a LovedTracks object' do
      expect(library.loved_tracks).to be_a(Notu::LovedTracks)
    end

    it 'always returns same object' do
      expect(library.loved_tracks.object_id).to be(library.loved_tracks.object_id)
    end

  end

  describe '#most_played_tracks' do

    it 'returns a LovedTracks object' do
      most_played_tracks = library.most_played_tracks
      expect(most_played_tracks).to be_a(Notu::MostPlayedTracks)
      expect(most_played_tracks.period).to eq('last_week')
    end

    it 'accepts options' do
      expect(library.most_played_tracks(period: 'last_month').period).to eq('last_month')
    end

  end

  describe '#username' do

    it 'is username set at initialization' do
      expect(library.username).to eq('alexistoulotte')
    end

    it 'can be specified as string' do
      expect(Notu::Library.new('username' => 'john42').username).to eq('john42')
    end

    it 'raise an error if nil' do
      expect {
        Notu::Library.new(username: nil)
      }.to raise_error(Notu::Error, 'Invalid Last.fm username: nil')
    end

    it 'raise an error if blank' do
      expect {
        Notu::Library.new(username: ' ')
      }.to raise_error(Notu::Error, 'Invalid Last.fm username: " "')
    end

    it 'raise an error if it contains spaces' do
      expect {
        Notu::Library.new(username: 'alexis toulotte')
      }.to raise_error(Notu::Error, 'Invalid Last.fm username: "alexis toulotte"')
    end

    it 'raise an error if invalid' do
      expect {
        Notu::Library.new(username: 'alex$')
      }.to raise_error(Notu::Error, 'Invalid Last.fm username: "alex$"')

      expect {
        Notu::Library.new(username: 'ALex^')
      }.to raise_error(Notu::Error, 'Invalid Last.fm username: "ALex^"')
    end

    it 'is stripped' do
      expect(Notu::Library.new(username: " alexis42 \n").username).to eq('alexis42')
    end

    it 'is downcased' do
      expect(Notu::Library.new(username: 'AlexIsT').username).to eq('alexist')
    end

  end

  describe '#url' do

    it 'returns default url if path not given' do
      expect(library.url).to eq('http://www.last.fm/user/alexistoulotte')
    end

    it 'returns default url if path is blank' do
      expect(library.url(path: ' ')).to eq('http://www.last.fm/user/alexistoulotte')
    end

    it 'accepts path option as string' do
      expect(library.url('path' => '/library/loved')).to eq('http://www.last.fm/user/alexistoulotte/library/loved')
    end

    it 'returns URL and path if given' do
      expect(library.url(path: '/library/loved')).to eq('http://www.last.fm/user/alexistoulotte/library/loved')
    end

    it 'adds first / to given path' do
      expect(library.url(path: 'library/loved')).to eq('http://www.last.fm/user/alexistoulotte/library/loved')
    end

    it 'use :host option set at initialization' do
      library = Notu::Library.new(host: 'www.lastfm.fr', username: 'albundy02')
      expect(library.url).to eq('http://www.lastfm.fr/user/albundy02')
    end

    it 'accepts query option' do
      expect(library.url(query: { bar: 42, 'baz' => 'hello&world' })).to eq('http://www.last.fm/user/alexistoulotte?bar=42&baz=hello%26world')
    end

  end

end
