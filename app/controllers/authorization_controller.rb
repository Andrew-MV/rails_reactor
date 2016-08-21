class AuthorizationController < ApplicationController

  def sign_up
    user = User.new(user_params)
    if user.save
      render json: user.to_json
    else
      render json: {
          message: 'Not valid user\'s data'
      }, status: 422
    end
  end

  def sign_in
    user = User.find_by(user_params)
    if user
      render json: user.to_json
    else
      render json: {
          message: 'User not found'
      }, status: 404 # todo find correct error code
    end
  end

  private

  def user_params
    params.permit(:login, :password)
  end

end