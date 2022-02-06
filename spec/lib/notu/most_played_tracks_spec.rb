require 'spec_helper'

describe Notu::MostPlayedTracks, :vcr do

  let(:library) { Notu::Library.new(username: 'alexistoulotte') }
  let(:most_played_tracks) { Notu::MostPlayedTracks.new(library) }

  describe '#library' do

    it 'is library given at initialization' do
      expect(most_played_tracks.library).to be(library)
    end

    it 'raise an error if library is nil' do
      expect {
        Notu::MostPlayedTracks.new(nil)
      }.to raise_error(ArgumentError, 'Notu::MostPlayedTracks#library must be a library, nil given')
    end

  end

  describe '#each' do

    it 'returns some tracks' do
      allow(most_played_tracks).to receive(:period).and_return('90 days')
      tracks = most_played_tracks.take(28)
      expect(tracks.size).to eq(28)
      tracks.each do |track|
        expect(track).to be_a(Notu::Track)
        expect(track.artist).to be_present
        expect(track.plays_count).to be > 0
        expect(track.title).to be_present
      end
    end

    it 'returns nil' do
      expect(most_played_tracks.each).to be_nil
    end

  end

  describe '#page_urls' do

    it 'is correct' do
      allow(most_played_tracks).to receive(:period).and_return('365 days')
      urls = most_played_tracks.page_urls
      expect(urls.size).to eq(most_played_tracks.pages_count)
      expect(urls).to include('https://www.last.fm/user/alexistoulotte/library/tracks?date_preset=LAST_365_DAYS&page=5')
      expect(urls).to include('https://www.last.fm/user/alexistoulotte/library/tracks?date_preset=LAST_365_DAYS&page=2')
    end

  end

  describe '#pages_count' do

    it 'is correct' do
      allow(most_played_tracks).to receive(:period).and_return('Overall')
      expect(most_played_tracks.pages_count).to be_within(150).of(250)
    end

  end

  describe '#params' do

    it 'includes period' do
      expect(most_played_tracks.params).to eq({ 'date_preset' => 'LAST_7_DAYS' })
    end

  end

  describe '#path' do

    it 'is "library/tracks"' do
      expect(most_played_tracks.path).to eq('library/tracks')
    end

  end

  describe '#period' do

    it 'is "7 days" by default' do
      expect(most_played_tracks.period).to eq('7 days')
    end

    it 'can be specified via option' do
      expect(Notu::MostPlayedTracks.new(library, period: '90 days').period).to eq('90 days')
    end

    it 'can be specified via option (as string)' do
      expect(Notu::MostPlayedTracks.new(library, 'period' => '90 days').period).to eq('90 days')
    end

    it 'raise an error if invalid' do
      expect {
        Notu::MostPlayedTracks.new(library, period: '180 days')
      }.to raise_error(ArgumentError, 'Notu::MostPlayedTracks#period is invalid: "180 days"')
    end

  end

end
