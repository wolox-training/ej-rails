# frozen_string_literal: true

class RentMailer < ApplicationMailer
  def new_rent_notification(rent)
    @rent = rent

    mail to: @rent.user.email, subject: 'You have rented a book!'
  end
end
