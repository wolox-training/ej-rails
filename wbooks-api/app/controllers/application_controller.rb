# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by using :null_session
  protect_from_forgery with: :null_session

  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json

  before_action :authenticate_user!
  # rubocop:disable Rails/LexicallyScopedActionFilter
  skip_before_action :authenticate_user!, only: [:create]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
