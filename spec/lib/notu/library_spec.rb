require 'spec_helper'

describe Notu::Library, :vcr do

  let(:library) { Notu::Library.new(username: 'alexistoulotte') }

  describe '#loved_tracks' do

    it 'returns a LovedTracks object' do
      expect(library.loved_tracks).to be_a(Notu::LovedTracks)
    end

  end

  describe '#most_played_tracks' do

    it 'returns a LovedTracks object' do
      most_played_tracks = library.most_played_tracks
      expect(most_played_tracks).to be_a(Notu::MostPlayedTracks)
      expect(most_played_tracks.period).to eq('7 days')
    end

    it 'accepts options' do
      expect(library.most_played_tracks(period: '30 days').period).to eq('30 days')
    end

  end

  describe '#played_tracks' do

    it 'returns a PlayedTrack object' do
      expect(library.played_tracks).to be_a(Notu::PlayedTracks)
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
      }.to raise_error(Notu::UnknownUsernameError, 'No such Last.fm username: nil')
    end

    it 'raise an error if blank' do
      expect {
        Notu::Library.new(username: ' ')
      }.to raise_error(Notu::UnknownUsernameError, 'No such Last.fm username: " "')
    end

    it 'raise an error if it contains spaces' do
      expect {
        Notu::Library.new(username: 'alexis toulotte')
      }.to raise_error(Notu::UnknownUsernameError, 'No such Last.fm username: "alexis toulotte"')
    end

    it 'raise an error if invalid' do
      expect {
        Notu::Library.new(username: 'alex$')
      }.to raise_error(Notu::UnknownUsernameError, 'No such Last.fm username: "alex$"')

      expect {
        Notu::Library.new(username: 'ALex^')
      }.to raise_error(Notu::UnknownUsernameError, 'No such Last.fm username: "ALex^"')
    end

    it 'is stripped' do
      expect(Notu::Library.new(username: " alexistoulotte \n").username).to eq('alexistoulotte')
    end

    it 'is downcased' do
      expect(Notu::Library.new(username: 'AlexIsT').username).to eq('alexist')
    end

    it 'raise an error if it does not exist' do
      expect {
        Notu::Library.new(username: 'jognjjeqwk')
      }.to raise_error(Notu::UnknownUsernameError, 'No such Last.fm username: "jognjjeqwk"')
    end

  end

  describe '#url' do

    it 'returns default url if path not given' do
      expect(library.url).to eq('https://www.last.fm/user/alexistoulotte')
    end

    it 'returns default url if path is blank' do
      expect(library.url(path: ' ')).to eq('https://www.last.fm/user/alexistoulotte')
    end

    it 'accepts path option as string' do
      expect(library.url('path' => '/library/loved')).to eq('https://www.last.fm/user/alexistoulotte/library/loved')
    end

    it 'returns URL and path if given' do
      expect(library.url(path: '/library/loved')).to eq('https://www.last.fm/user/alexistoulotte/library/loved')
    end

    it 'adds first / to given path' do
      expect(library.url(path: 'library/loved')).to eq('https://www.last.fm/user/alexistoulotte/library/loved')
    end

    it 'accepts query option' do
      expect(library.url(query: { bar: 42, 'baz' => 'hello&world' })).to eq('https://www.last.fm/user/alexistoulotte?bar=42&baz=hello%26world')
    end

  end

end
