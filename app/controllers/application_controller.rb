class ApplicationController < ActionController::API

  def send_success(message, status = :ok)
    render json: {errors: nil, body: message}, status: status
  end
  def send_error(message, status)
    render json: {errors: message, body: nil}, status: status
  end
end
