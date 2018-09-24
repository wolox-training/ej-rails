# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RentMailer, type: :mailer do
  describe 'new_rent_notification' do
    let(:user) { create(:user) }
    let(:rent) { create(:rent, user: user) }
    let(:mail) { RentMailer.new_rent_notification(rent) }

    it 'renders the headers' do
      expect(mail.subject).to eq('You have rented a book!')
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
