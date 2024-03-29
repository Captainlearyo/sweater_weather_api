require 'rails_helper'

RSpec.describe "Create User" do
    it "Happy Path creates a new user when givin valid info" do
      users = {
        "email": "yahoo.com",
        "password": "1234",
        "password_confirmation": "1234"
      }

      post "/api/v0/users", params: users, as: :json

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      #binding.pry
      expect( json_response).to have_key(:data)
      expect( json_response[:data]).to have_key(:type)
      expect( json_response[:data]).to have_key :id
      expect( json_response[:data][:id]).to_not be nil
      expect( json_response[:data][:type]).to eq("users")
      expect( json_response[:data][:attributes]).to have_key(:email)
      expect( json_response[:data][:attributes]).to have_key(:api_key)

    end

    it "Sad Path creates a new user when givin invalid info :password" do
      user = {
        "name": "John",
        "email": "yahoo.com",
        "password": "1234",
        "password_confirmation": "4321"
      }

      post "/api/v0/users", params: user, as: :json

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect( json_response).to be_a(Hash)
      expect( json_response).to have_key(:error)
      expect( json_response[:error]).to eq(400)
      
    
    end

    it "Sad Path creates a new user when givin invalid info :email not unique" do
      User.create( email: "yahoo.com", password: "1234", password_confirmation: "1234")

      user = {
        "email": "yahoo.com",
        "password": "1234",
        "password_confirmation": "1234"
      }

      post "/api/v0/users", params: user, as: :json

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect( json_response).to be_a(Hash)
      expect( json_response).to have_key(:error)
      expect( json_response[:error]).to eq("invlalid infomation")
    
    end
end