module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from RestClient::ExceptionWithResponse, with: :response_error
    rescue_from SocketError, with: :socket_error
    # rescue_from StandardError, with: :standard_error
  end

  private

  def response_error(exception)
    render json: { error: "Service error: #{exception.message}" }, status: :unprocessable_entity
  end

  def socket_error(exception)
    render json: { error: "Network error: #{exception.message}" }, status: :unprocessable_entity
  end

  # def standard_error(exception)
  #   render json: { error: "An error occurred: #{exception.message}" }, status: :internal_server_error
  # end
end