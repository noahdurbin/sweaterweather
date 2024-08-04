class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  private

  def render_unprocessable_entity_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.record.errors.full_messages.to_sentence, 422)).serialize, status: :unprocessable_entity
  end
end
