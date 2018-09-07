# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by using :null_session
  protect_from_forgery with: :null_session

  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json

  before_action :authenticate_user!
  # rubocop:disable Rails/LexicallyScopedActionFilter
  skip_before_action :authenticate_user!, only: [:create]
end
