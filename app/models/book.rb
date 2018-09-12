# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :rents, dependent: :nullify
  has_many :users, through: :rents

  validates :genre, :author, :image, :title, :publisher, :year, presence: true
end
