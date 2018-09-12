# frozen_string_literal: true

require 'rails_helper'

describe Rent do
  it { should validate_presence_of(:loan) }
  it { should validate_presence_of(:restitution) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:book) }

  it do
    expect(build(:rent)).to be_valid
  end

  describe '#create' do
    context 'When the loan is greater than restitution date' do
      it 'is not valid' do
        expect(build(:rent, loan: Faker::Date.forward(10), restitution: Faker::Date.backward(10)))
          .not_to be_valid
      end
    end

    context 'When the book is not available' do
      let!(:book) { create(:book) }
      let!(:rent) do
        create(:rent, loan: Faker::Date.between(5.days.ago, 2.days.ago), book: book,
                      restitution:  Faker::Date.between(Time.zone.today + 5.days,
                                                        Time.zone.today + 10.days))
      end

      it 'is not valid' do
        expect(build(:rent, book: book, loan: Time.zone.today)).not_to be_valid
      end
    end
  end
end
