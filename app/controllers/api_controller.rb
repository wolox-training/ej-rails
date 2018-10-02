# frozen_string_literal: true

class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :create
  protect_from_forgery with: :null_session

  include Wor::Paginate
  include Pundit

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def create; end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    message = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    render json: { error: message }, status: :forbidden
  end
end
