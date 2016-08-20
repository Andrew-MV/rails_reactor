class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json, :html

  def index
  end

  def analyze
    input = params[:dataset].split(',').map { |x| x.strip.to_i }
    output = {}
    output[:min] = input.min
    output[:max] = input.max
    output[:average] = input.reduce(:+) * 1.0 / input.size
    output[:q1] = input.max
    output[:q3] = input.max
    output[:median] = input.max
    output[:outliers] = input.max
    render json: {
        average: output[:average],
        min: output[:min],
        max: output[:max],
        q1: output[:q1],
        q3: output[:q3],
        median: output[:median],
        outliers: output[:outliers]
    }
  end


end