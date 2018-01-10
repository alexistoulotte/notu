require 'spec_helper'

describe Notu::NetworkError do

  let(:error) { Notu::NetworkError.new('BAM!') }

  describe '#message' do

    it 'is message set at initialization' do
      expect(error.message).to eq('BAM!')
    end

  end

end
