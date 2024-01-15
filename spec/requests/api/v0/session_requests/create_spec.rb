require 'rails_helper'

RSpec.describe "Create Session" do
    it "Happy Path verify's users email and password and sends response back" do
      User.create(email: "yahoo.com", password: "1234", password_confirmation: "1234")

      user_login = {
        "email": "yahoo.com",
        "password": "1234",
        "password_confirmation": "1234"
      }

      post "/api/v0/sessions", params: user_login, as: :json

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      #binding.pry
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to_not be nil
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq("users")
      expect( json_response[:data][:attributes]).to have_key(:email)
      expect( json_response[:data][:attributes]).to have_key(:api_key)

    end

    it "Sad Path " do
      User.create(email: "yahoo.com", password: "1234", password_confirmation: "1234")

      user_login = {
        "email": "yahoo.com",
        "password": "134",
        "password_confirmation": "1234"
      }

      post "/api/v0/sessions", params: user_login, as: :json

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect( json_response).to have_key(:error)
      expect( json_response[:error]).to eq("User name or password incorrect")
    
    end
end