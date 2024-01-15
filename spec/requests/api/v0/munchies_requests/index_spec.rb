require 'rails_helper'

RSpec.describe 'Munchies Index', type: :request do 
  it 'Happy Path returns a destination data', :vcr do

    destination = "Dallas,TX"
    food = "Italian"

    get "/api/v0/munchies?destination=#{destination}&food=#{food}"
    
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    #binding.pry
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:data)

    data = json_response[:data]
    expect(data).to be_an(Hash)
    expect(data[:id]).to eq(nil)
    expect(data).to have_key(:type)
    expect(data[:type]).to eq("munchie")
    expect(data).to have_key(:attributes)

    attributes = data[:attributes]
  
    expect(attributes).to have_key(:destination_city)
    expect(attributes[:destination_city]).to be_a(String)
    expect(attributes).to have_key(:forecast)
    expect(attributes[:forecast]).to have_key(:summary)
    expect(attributes[:forecast][:summary]).to be_a(String)
    expect(attributes[:forecast]).to have_key(:temperature)
    expect(attributes[:forecast][:temperature]).to be_a(Integer)
    
    expect(attributes).to have_key(:restaurant)
    expect(attributes[:restaurant]).to have_key(:name)
    expect(attributes[:restaurant][:name]).to be_a(String)
    expect(attributes[:restaurant]).to have_key(:address)
    expect(attributes[:restaurant][:address]).to be_a(String)
    expect(attributes[:restaurant]).to have_key(:rating)
    expect(attributes[:restaurant][:rating]).to be_a(Float)
    expect(attributes[:restaurant]).to have_key(:reviews)
    expect(attributes[:restaurant][:reviews]).to be_a(Integer)
  end
end