require 'spec_helper'

describe Notu::Track do

  let(:track) { Notu::Track.new(artist: 'Serial Killaz', title: 'Good Enough') }

  describe '#<=>' do

    let(:other) { track.dup }

    it 'compares track by artist' do
      expect {
        allow(other).to receive(:artist).and_return('Technimatic')
      }.to change { track <=> other }.from(0).to(-1)
    end

    it 'compares track by artist and then by title' do
      expect {
        allow(other).to receive(:title).and_return('Send Dem')
      }.to change { track <=> other }.from(0).to(-1)
    end

    it 'returns nil if given track is not a track' do
      expect(track <=> nil).to be_nil
      expect(track <=> 'foo').to be_nil
    end

  end

  describe '#==' do

    let(:other) { track.dup }

    it 'is false if not a track' do
      expect(track == 'foo').to be(false)
    end

    it 'is false if artist differs' do
      expect {
        allow(other).to receive(:artist).and_return('Foo')
      }.to change { track == other }.from(true).to(false)
    end

    it 'is false if title differs' do
      expect {
        allow(other).to receive(:title).and_return('Bar')
      }.to change { track == other }.from(true).to(false)
    end

    it 'is true if plays_count differs' do
      expect {
        allow(other).to receive(:plays_count).and_return(102)
      }.not_to change { track == other }
    end

  end

  describe '#eql?' do

    it 'is true for same object' do
      expect(track.eql?(track)).to be(true)
    end

    it 'is true if == returns true' do
      other = track.dup
      expect {
        allow(track).to receive(:==).and_return(false)
      }.to change { track.eql?(other) }.from(true).to(false)
    end

  end

  describe '#artist' do

    it 'is value set at initialization' do
      expect(track.artist).to eq('Serial Killaz')
    end

    it 'is squished' do
      expect(Notu::Track.new(artist: 'Serial  Killaz  ', title: 'Good Enough').artist).to eq('Serial Killaz')
    end

    it 'raise an error if blank' do
      expect {
        Notu::Track.new(artist: ' ', title: 'Good Enough')
      }.to raise_error(Notu::Error, 'Notu::Track#artist must be specified, " " given')
    end

  end

  describe '#plays_count' do

    it 'is nil by default' do
      expect(track.plays_count).to be_nil
    end

    it 'can be specified' do
      expect(Notu::Track.new(artist: 'Serial Killaz', plays_count: 42, title: 'Good Enough').plays_count).to eq(42)
    end

    it 'can be specified (as string)' do
      expect(Notu::Track.new(artist: 'Serial Killaz', plays_count: '42', title: 'Good Enough').plays_count).to eq(42)
    end

    it 'is nil if invalid' do
      expect(Notu::Track.new(artist: 'Serial Killaz', plays_count: 'foo', title: 'Good Enough').plays_count).to be_nil
    end

    it 'is 0 if negatve' do
      expect(Notu::Track.new(artist: 'Serial Killaz', plays_count: -1, title: 'Good Enough').plays_count).to eq(0)
    end

  end

  describe '#title' do

    it 'is value set at initialization' do
      expect(track.title).to eq('Good Enough')
    end

    it 'is squished' do
      expect(Notu::Track.new(artist: 'Serial Killaz', title: '  Good  Enough').title).to eq('Good Enough')
    end

    it 'raise an error if blank' do
      expect {
        Notu::Track.new(artist: 'Serial Killaz', title: ' ')
      }.to raise_error(Notu::Error, 'Notu::Track#title must be specified, " " given')
    end

  end

  describe '#to_s' do

    it 'is "artist - title"' do
      expect(track.to_s).to eq('Serial Killaz - Good Enough')
    end

  end

end
