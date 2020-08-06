class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordInvalid do |e|
    send_error(e.message, :unprocessable_entity)
  end


  def send_success(message, status = :ok)
    render json: {errors: nil, body: message}, status: status
  end
  def send_error(message, status)
    render json: {errors: message, body: nil}, status: status
  end
end
