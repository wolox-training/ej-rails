# frozen_string_literal: true

class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :loan, :restitution, :book, :user, presence: true
  validate :book_availability, :loan_cannot_be_greater_than_restitution_date, on: :create

  scope :actual, lambda {
    current_date = Date.current
    rents = where('loan <= ? AND restitution >= ?', current_date, current_date)
    rents.empty? ? {} : rents.first
  }

  def book_availability
    return true if book.blank?
    rents = Rent.where(book_id: book.id).where('loan <= ? AND restitution >= ?', loan, loan)
    errors.add(:loan, "can't be between another rent dates") unless rents.empty?
  end

  def loan_cannot_be_greater_than_restitution_date
    return true if loan.blank?
    errors.add(:loan, "can't be greater than restitution date") if loan > restitution
  end
end
