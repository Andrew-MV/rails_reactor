class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json, :html

  def index
  end

  def analyze
    dataset = params[:dataset].to_s.strip
    error_message = validate_data(dataset)[:message].first
    error_status = validate_data(dataset)[:status]
    if error_status
      render json: {
          message: error_message
      }, status: error_status
    else
      input = dataset.split(',').map { |num| num.strip.to_i }
      output = {}
      output[:min] = input.min
      output[:max] = input.max
      output[:average] = input.max
      output[:q1] = input.max
      output[:q3] = input.max
      output[:median] = input.max
      output[:outliers] = input.max
      render json: output
    end
  end

  def correlate
    dataset1 = params[:dataset1].to_s.strip
    error_message1 = validate_data(dataset1)[:message].first
    error_status1 = validate_data(dataset1)[:status]
    dataset2 = params[:dataset2].to_s.strip
    error_message2 = validate_data(dataset2)[:message].first
    error_status2 = validate_data(dataset2)[:status]
    if error_status1
      render json: {
          message: error_message1 + ' in first array'
      }, status: error_status1
    elsif error_status2
      render json: {
          message: error_message2 + ' in second array'
      }, status: error_status2
    else
      input1 = dataset1.split(',').map { |num| num.strip.to_i }
      input2 = dataset2.split(',').map { |num| num.strip.to_i }
      if input1.size != input2.size
        render json: {
            message: 'Arrays should have equal size'
        }, status: 422
      else
        output = {}
        output[:answer] = 'correlation result'
        render json: output
      end
    end
  end

  private

  def validate_data(dataset)
    # todo add correct error messages
    error = { message: [], status: nil }
    if dataset.empty?
      error[:message] << 'Empty dataset'
      error[:status] = 422
    else
      dataset = dataset.split(',')
      if dataset.size < 3
        error[:message] << 'Enter at least 3 numbers'
        error[:status] = 422
      elsif
      dataset.any? { |num| !/\A[-+]?\d+\z/.match(num.strip) }
        error[:message] << 'Wrong data'
        error[:status] = 422
      end
    end
    error
  end

end