require 'spec_helper'

describe Notu::TopTracks, :vcr do

  let(:top_tracks) { Notu::TopTracks.new(user_api) }
  let(:user_api) { Notu::UserApi.new(username: 'alexistoulotte') }

  describe '#each' do

    it 'returns some tracks' do
      allow(top_tracks).to receive(:period).and_return('90 days')
      tracks = top_tracks.take(28)
      expect(tracks.size).to eq(28)
      tracks.each do |track|
        expect(track).to be_a(Notu::Track)
        expect(track.artist).to be_present
        expect(track.plays_count).to be > 0
        expect(track.title).to be_present
      end
    end

  end

  describe '#period' do

    it 'is "overall" by default' do
      expect(top_tracks.period).to eq('overall')
    end

    it 'can be specified via option' do
      expect(Notu::TopTracks.new(user_api, period: '3month').period).to eq('3month')
    end

    it 'can be specified via option (as string)' do
      expect(Notu::TopTracks.new(user_api, 'period' => '12month').period).to eq('12month')
    end

    it 'raise an error if invalid' do
      expect {
        Notu::TopTracks.new(user_api, period: '42month')
      }.to raise_error(ArgumentError, 'Notu::TopTracks#period is invalid: "42month"')
    end

  end

  describe '#user_api' do

    it 'is user_api given at initialization' do
      expect(top_tracks.user_api).to be(user_api)
    end

    it 'raise an error if user_api is nil' do
      expect {
        Notu::TopTracks.new(nil)
      }.to raise_error(ArgumentError, 'Notu::TopTracks#user_api must be specified')
    end

  end

end
