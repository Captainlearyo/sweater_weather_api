require 'rails_helper'

RSpec.describe MunchiesSerializer do
  it 'returns destination_data as json', :vcr do
    location = "Dallas,TX"
    term = "Italian"

    result = MunchiesFacade.destination_data(location, term)

    serialized_location =  MunchiesSerializer.new(result).serializable_hash
    # binding.pry
    expect(serialized_location[:data][:id]).to be_nil
    expect(serialized_location[:data][:type]).to eq(:munchie)

    attributes = serialized_location[:data][:attributes]
    expect(attributes[:destination_city]).to be_a(String)
    expect(attributes[:forecast][:summary]).to be_a(String)
    expect(attributes[:forecast][:temperature]).to be_a(Integer)

    expect(attributes[:restaurant][:name]).to be_a(String)
    expect(attributes[:restaurant][:address]).to be_a(String)
    expect(attributes[:restaurant][:rating]).to be_a(Float)
    expect(attributes[:restaurant][:reviews]).to be_a(Integer)
  end
end