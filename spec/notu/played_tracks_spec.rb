require 'spec_helper'

describe Notu::PlayedTracks, :vcr do

  let(:library) { Notu::Library.new(username: 'alexistoulotte') }
  let(:played_tracks) { Notu::PlayedTracks.new(library) }

  describe '#each' do

    it 'returns some tracks' do
      tracks = played_tracks.take(42)
      expect(tracks.size).to eq(42)
      tracks.each do |track|
        expect(track).to be_a(Notu::Track)
        expect(track.artist).to be_present
        expect(track.plays_count).to be_nil
        expect(track.title).to be_present
      end
    end

    it 'returns nil' do
      allow(played_tracks).to receive(:pages_count).and_return(1)
      expect(played_tracks.each {}).to be_nil
    end

  end

  describe '#page_urls' do

    it 'is correct' do
      urls = played_tracks.page_urls
      expect(urls.size).to eq(played_tracks.pages_count)
      expect(urls).to include('http://www.last.fm/user/alexistoulotte/library?page=12')
      expect(urls).to include('http://www.last.fm/user/alexistoulotte/library?page=3')
    end

  end

  describe '#pages_count' do

    it 'is correct' do
      expect(played_tracks.pages_count).to be_within(500).of(1500)
    end

  end

  describe '#params' do

    it 'is an empty hash' do
      expect(played_tracks.params).to eq({})
    end

  end

  describe '#path' do

    it 'is "library"' do
      expect(played_tracks.path).to eq('library')
    end

  end
end
