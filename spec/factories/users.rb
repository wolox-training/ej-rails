# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email       { Faker::Internet.safe_email }
    password    { Faker::Internet.password(8) }
    nickname    { Faker::Internet.username(5..8) }
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name  }
  end
end
