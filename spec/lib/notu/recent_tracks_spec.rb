require 'spec_helper'

describe Notu::RecentTracks, :vcr do

  let(:recent_tracks) { Notu::RecentTracks.new(user_api) }
  let(:user_api) { Notu::UserApi.new(username: 'alexistoulotte') }

  describe '#each' do

    it 'returns some tracks' do
      tracks = recent_tracks.take(42)
      expect(tracks.size).to eq(42)
      tracks.each do |track|
        expect(track).to be_a(Notu::Track)
        expect(track.artist).to be_present
        expect(track.plays_count).to be_nil
        expect(track.title).to be_present
      end
    end

  end

end
