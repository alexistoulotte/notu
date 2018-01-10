require 'spec_helper'

describe Notu::UnknownUsernameError do

  let(:error) { Notu::UnknownUsernameError.new('foo') }

  describe '#message' do

    it 'is message constructed at initialization' do
      expect(error.message).to eq('No such Last.fm username: "foo"')
    end

  end

  describe '#username' do

    it 'returns username set at initialization' do
      expect(error.username).to eq('foo')
    end

  end

end
