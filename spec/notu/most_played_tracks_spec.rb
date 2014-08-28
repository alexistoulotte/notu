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
      allow(most_played_tracks).to receive(:period).and_return('last_month')
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
      expect(most_played_tracks.each {}).to be_nil
    end

  end

  describe '#period' do

    it 'is "last_week" by default' do
      expect(most_played_tracks.period).to eq('last_week')
    end

    it 'can be specified via option' do
      expect(Notu::MostPlayedTracks.new(library, period: 'last_6_months').period).to eq('last_6_months')
    end

    it 'can be specified via option (as string)' do
      expect(Notu::MostPlayedTracks.new(library, 'period' => 'last_6_months').period).to eq('last_6_months')
    end

    it 'raise an error if invalid' do
      expect {
        Notu::MostPlayedTracks.new(library, period: 'foo')
      }.to raise_error(ArgumentError, 'Notu::MostPlayedTracks#period is invalid: "foo"')
    end

  end

end
