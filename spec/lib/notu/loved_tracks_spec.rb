require 'spec_helper'

describe Notu::LovedTracks, :vcr do

  let(:library) { Notu::Library.new(username: 'alexistoulotte') }
  let(:loved_tracks) { Notu::LovedTracks.new(library) }

  describe '#each' do

    it 'returns some tracks' do
      tracks = loved_tracks.take(42)
      expect(tracks.size).to eq(42)
      tracks.each do |track|
        expect(track).to be_a(Notu::Track)
        expect(track.artist).to be_present
        expect(track.plays_count).to be_nil
        expect(track.title).to be_present
      end
    end

  end

  describe '#library' do

    it 'is library given at initialization' do
      expect(loved_tracks.library).to be(library)
    end

    it 'raise an error if library is nil' do
      expect {
        Notu::LovedTracks.new(nil)
      }.to raise_error(ArgumentError, 'Notu::LovedTracks#library must be a library, nil given')
    end

  end

end
