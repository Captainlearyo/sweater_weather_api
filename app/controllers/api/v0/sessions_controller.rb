class Api::V0::SessionsController < ApplicationController
  def create
    json_response = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: json_response[:email])
    if user.authenticate(json_response[:password])
      render json: UserSerializer.new(user)
    else
      render json: { error: "User name or password incorrect" }, status: :not_found
    end
  end
end