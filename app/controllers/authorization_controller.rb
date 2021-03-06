class AuthorizationController < ApplicationController

  respond_to :json, :html

  include JsonApiHeaders
  include JsonApiErrors

  before_action :set_content_type, only: [:sign_up, :sign_in, :log_out, :verify_token]

  def sign_up
    user = User.new(user_params)
    if user.save
      session[:authorization_token] = user.authorization_token
      render json: user.to_json_api_schema({ authorization_token: user.authorization_token })
    else
      render json: to_json_api_errors(:user_exists), status: 400
    end
  end

  def sign_in
    user = User.authenticate(params[:meta][:login], params[:meta][:password])
    if user
      session[:authorization_token] = user.authorization_token
      render json: user.to_json_api_schema({ authorization_token: user.authorization_token })
    else
      render json: to_json_api_errors(:invalid_login_or_password), status: 400
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
    if (session[:authorization_token].to_s == params[:meta][:authorization_token].to_s) && (params[:meta][:authorization_token].to_s != '')
      user_id = session[:authorization_token].split('_').first
      user = User.find(user_id)
      if user
        render json: user.to_json_api_schema
      else
        render json: to_json_api_errors(:user_not_found), status: 404
      end
    else
      render json: to_json_api_errors(:invalid_token), status: 400
    end
  end

  private

  def user_params
    params[:meta].permit(:login, :password)
  end

end