class AuthorizationController < ApplicationController

  include JsonApiErrors

  def sign_up
    user = User.new(user_params)
    if user.save
      session[:authorization_token] = user.authorization_token
      render json: user.to_json_api_schema({ authorization_token: user.authorization_token })
    else
      render json: to_json_api_errors(:user_exists), status: 422
    end
  end

  def sign_in
    user = User.find_by(user_params)
    if user
      session[:authorization_token] = user.authorization_token
      render json: user.to_json_api_schema({ authorization_token: user.authorization_token })
    else
      render json: to_json_api_errors(:invalid_login_or_password), status: 404
      # todo find correct error code
    end
  end

  def log_out
    session.delete(:authorization_token)
    render json: {
        meta: {
            message: 'logged out'
        }
    }
  end

  def verify_token
    if (session[:authorization_token].to_s == params[:authorization_token].to_s) && (params[:authorization_token].to_s != '')
      user_id = session[:authorization_token].split('_').first
      user = User.find(user_id)
      if user
        render json: user.to_json_api_schema
      else
        render json: {
            errors: [{
                message: 'user not found',
                status: 422
            }]
        }, status: 422
      end
    else
      render json: {
          errors: [{
              message: 'invalid token',
              status: 422
          }]
      }, status: 422
    end
  end

  private

  def user_params
    params.permit(:login, :password)
  end

end