class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json, :html


  def index
  end

  def analyze
    # response.headers['Content-Type'] = 'application/vnd.api+json'
    dataset = params[:dataset].to_s.strip
    error_message = validate_data(dataset)[:message].first
    error_status = validate_data(dataset)[:status]
    if error_status
      render json: {
      # todo make according to json api
          message: error_message
      }, status: error_status
    else
      input = dataset.split(',').map { |num| num.strip.to_i }
      output = {}
      output[:min] = input.min
      output[:max] = input.max
      output[:average] = find_average(input).round(3)
      output[:q1] = find_q1(input)
      output[:q3] = find_q3(input)
      output[:median] = find_median(input)
      output[:outliers] = find_outliers(input)
      render json: output
      # todo make according to json api
    end
  end

  def correlate
    # response.headers['Content-Type'] = 'application/vnd.api+json'
    dataset1 = params[:dataset1].to_s.strip
    error_message1 = validate_data(dataset1)[:message].first
    error_status1 = validate_data(dataset1)[:status]
    dataset2 = params[:dataset2].to_s.strip
    error_message2 = validate_data(dataset2)[:message].first
    error_status2 = validate_data(dataset2)[:status]
    if error_status1
      render json: {
          # todo make according to json api
          message: error_message1 + ' in first array'
      }, status: error_status1
    elsif error_status2
      render json: {
          # todo make according to json api
          message: error_message2 + ' in second array'
      }, status: error_status2
    else
      input1 = dataset1.split(',').map { |num| num.strip.to_i }
      input2 = dataset2.split(',').map { |num| num.strip.to_i }
      if input1.size != input2.size
        render json: {
            # todo make according to json api
            message: 'Arrays should have equal size'
        }, status: 422
      else
        output = {}
        output[:answer] = find_correlation(input1, input2).round(3)
        render json: output
        # todo make according to json api
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

  def find_average(array)
    array.reduce(:+).fdiv(array.size)
  end

  def find_median(array)
    index = array.size - 1
    array.sort[(index / 2)..(index - (index / 2))].reduce(:+).fdiv(2 ** (index % 2))
  end

  def find_q1(array)
    find_median(array.sort[0..(array.size / 2 - 1)])
  end

  def find_q3(array)
    index = array.size + 1
    find_median(array.sort[(index / 2)..-1])
  end

  def find_outliers(array)
    outliers = []
    diff = find_q3(array) - find_q1(array)
    left_border = find_q1(array) - 1.5 * diff
    right_border = find_q3(array) + 1.5 * diff
    array.each do |num|
      outliers << num unless (left_border..right_border) === num
    end
    outliers.empty? ? 'None' : outliers.sort.join('; ')
  end

  def find_correlation(array1, array2)
    arr1_avg = find_average(array1)
    arr2_avg = find_average(array2)
    numerator = arr1_sum = arr2_sum = 0
    array1.size.times do |index|
      numerator += (array1[index] - arr1_avg) * (array2[index] - arr2_avg)
      arr1_sum += (array1[index] - arr1_avg) ** 2
      arr2_sum += (array2[index] - arr2_avg) ** 2
    end
    numerator.fdiv((arr1_sum * arr2_sum) ** 0.5)
  end

end