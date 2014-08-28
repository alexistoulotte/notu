require 'spec_helper'

describe Notu::ParseError do

  let(:error) { Notu::ParseError.new('BAM!') }

  describe '#message' do

    it 'is message set at initialization' do
      expect(error.message).to eq('BAM!')
    end

  end

end
