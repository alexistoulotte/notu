require 'spec_helper'

describe Notu::LovedTracks, :vcr do

  let(:loved_tracks) { Notu::LovedTracks.new(user_api) }
  let(:user_api) { Notu::UserApi.new(username: 'alexistoulotte') }

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

  describe '#user_api' do

    it 'is user_api given at initialization' do
      expect(loved_tracks.user_api).to be(user_api)
    end

    it 'raise an error if user_api is nil' do
      expect {
        Notu::LovedTracks.new(nil)
      }.to raise_error(ArgumentError, 'Notu::LovedTracks#user_api must be specified')
    end

  end

end
