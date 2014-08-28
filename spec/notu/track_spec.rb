require 'spec_helper'

describe Notu::Track do

  let(:track) { Notu::Track.new(artist: 'Serial Killaz', title: 'Good Enough') }

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

end
