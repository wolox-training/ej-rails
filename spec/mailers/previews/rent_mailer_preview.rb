# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/rent_mailer
class RentMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/rent_mailer/new_rent_notification
  def new_rent_notification
    RentMailer.new_rent_notification(Rent.first)
  end
end
