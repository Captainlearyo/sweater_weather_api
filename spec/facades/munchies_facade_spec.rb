require 'rails_helper'

RSpec.describe 'Munchies Facade', :vcr do
  it 'returns destination_data', :vcr do

    location = "Dallas,TX"
    term = "Italian"

    result = MunchiesFacade.destination_data(location, term)

    expect(result.destination_city).to eq(location)
    
    expect(result.forecast).to be_a(Hash)
    expect(result.forecast[:summary]).to be_a(String)
    expect(result.forecast[:temperature]).to be_a(Integer)

    expect(result.restaurant).to be_a(Hash)
    expect(result.restaurant[:name]).to be_a(String)
    expect(result.restaurant[:address]).to be_a(String)
    expect(result.restaurant[:rating]).to be_a(Float)
    
      
  end
end