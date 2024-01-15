class Api::V0::MunchiesController < ApplicationController
  def index
    restraurant = MunchiesFacade.destination_data(params[:destination], params[:food])
    render json: MunchiesSerializer.new(restraurant)
  end
end