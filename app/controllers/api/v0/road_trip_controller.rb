class Api::V0::RoadTripController < ApplicationController
  def create
    json_response = JSON.parse(request.body.read, symbolize_names: true)
    if json_response[:api_key].blank? || json_response[:api_key] != "valid_api_key"
      render json: { error: 401 }, status: :unauthorized
      return
    end
    trip_data = RoadtripFacade.plan_trip(json_response)
    render json: RoadtripSerializer.new(trip_data)
  end
end