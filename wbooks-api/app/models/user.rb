# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :first_name, :last_name, presence: true
end
