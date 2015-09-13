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

    it 'returns nil' do
      allow(loved_tracks).to receive(:pages_count).and_return(1)
      expect(loved_tracks.each {}).to be_nil
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

  describe '#page_urls' do

    it 'is correct' do
      urls = loved_tracks.page_urls
      expect(urls.size).to eq(loved_tracks.pages_count)
      expect(urls).to include('http://www.last.fm/user/alexistoulotte/loved?page=12')
      expect(urls).to include('http://www.last.fm/user/alexistoulotte/loved?page=3')
    end

  end

  describe '#pages_count' do

    it 'is correct' do
      expect(loved_tracks.pages_count).to be_within(10).of(30)
    end

  end

  describe '#params' do

    it 'is an empty hash' do
      expect(loved_tracks.params).to eq({})
    end

  end

  describe '#path' do

    it 'is "loved"' do
      expect(loved_tracks.path).to eq('loved')
    end

  end

end
