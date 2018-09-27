# frozen_string_literal: true

class BookSuggestion < ApplicationRecord
  belongs_to :user, optional: true

  validates :author, :title, :link, presence: true
end
