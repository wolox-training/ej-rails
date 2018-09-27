# frozen_string_literal: true

FactoryBot.define do
  factory :book_suggestion do
    editorial { Faker::Book.publisher }
    price     { Faker::Internet.url }
    author    { Faker::Book.author }
    title     { Faker::Book.title }
    link      { Faker::Internet.url }
    year      { Faker::Date.backward.year }
    publisher { Faker::Book.publisher }
    user
  end
end
