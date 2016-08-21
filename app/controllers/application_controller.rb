class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json, :html

  def index
  end

  def analyze
    dataset = params[:dataset].to_s.strip
    if dataset.empty?
      render json: {
          message: 'Empty dataset'
      }, status: 422
    else
      dataset = dataset.split(',')

      if dataset.size < 3
        render json: {
            message: 'Enter at least 3 numbers'
        }, status: 422
      elsif dataset.any? { |num| !/\A[-+]?\d+\z/.match(num.strip) }
        render json: {
            message: 'Wrong data'
        }, status: 422
      else
        input = dataset.map { |num| num.strip.to_i }
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
  end

  def correlate
    dataset1 = params[:dataset1].to_s.strip
    dataset2 = params[:dataset2].to_s.strip
    if dataset1.empty?
      render json: {
          message: 'Empty dataset'
      }, status: 422
    else
      dataset1 = dataset1.split(',')

      if dataset1.size < 3
        render json: {
            message: 'Enter at least 3 numbers'
        }, status: 422
      elsif dataset1.any? { |num| !/\A[-+]?\d+\z/.match(num.strip) }
        render json: {
            message: 'Wrong data'
        }, status: 422
      else
        input1 = dataset1.map { |num| num.strip.to_i }
        output = {}
        output[:answer] = 'answer'
        render json: {
            correlation: output[:answer]
        }
      end
    end
  end

end