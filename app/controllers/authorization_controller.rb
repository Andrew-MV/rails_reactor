class AuthorizationController < ApplicationController

  def sign_up
    user = User.new(user_params)
    if user.save
      output = {}
      authorization_token = "#{user.id}_#{user.password}"
      output[:authorization_token] = session[:authorization_token] = authorization_token
      output[:user] = user
      render json: output.to_json
    else
      render json: {
          message: 'Not valid user\'s data'
      }, status: 422
    end
  end

  def sign_in
    user = User.find_by(user_params)
    if user
      output = {}
      authorization_token = "#{user.id}_#{user.password}"
      output[:authorization_token] = session[:authorization_token] = authorization_token
      output[:user] = user
      render json: output.to_json
    else
      render json: {
          message: 'User not found'
      }, status: 404 # todo find correct error code
    end
  end

  def log_out
    session.delete(:authorization_token)
    render json: {
        message: 'logged out'
    }
  end

  def verify_token
    if (session[:authorization_token].to_s == params[:authorization_token].to_s) && (params[:authorization_token].to_s != '')
      user_id = session[:authorization_token].split('_').first
      user = User.find(user_id)
      if user
        render json: {
            user: user
        }
      else
        render json: {
            message: 'user not found'
        }
      end
    else
      render json: {
          message: 'invalid token'
      }, status: 422
    end
  end

  private

  def user_params
    params.permit(:login, :password)
  end

end