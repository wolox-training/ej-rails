# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by using :null_session
  protect_from_forgery with: :null_session
end
