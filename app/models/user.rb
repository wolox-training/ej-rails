# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :rents, dependent: :nullify
  has_many :books, through: :rents
  has_many :book_suggestions, dependent: :destroy

  validates :first_name, :last_name, presence: true
end
