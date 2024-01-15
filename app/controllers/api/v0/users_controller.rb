class Api::V0::UsersController < ApplicationController

  def create
    json_response = JSON.parse(request.body.read, symbolize_names: true)
    user = User.new(email: json_response[:email], password: json_response[:password])
    if json_response[:password] != json_response[:password_confirmation]
      render json: {error: 400}
    elsif user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { error: 'invlalid infomation' }, status: :not_found
    end
  end
end