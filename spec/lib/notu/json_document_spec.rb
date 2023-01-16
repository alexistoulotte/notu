require 'spec_helper'

describe Notu::JsonDocument, :vcr do

  it 'parse returned JSON' do
    json = Notu::JsonDocument.get('https://dummyjson.com/products/1')
    expect(json['description']).to eq('An apple mobile which is nothing like apple')
  end

end
