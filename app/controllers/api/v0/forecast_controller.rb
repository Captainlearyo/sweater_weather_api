class Api::V0::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.city_forcast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end