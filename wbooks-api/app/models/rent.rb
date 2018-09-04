# frozen_string_literal: true

class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :loan, :restitution, :book, :user, presence: true
end
