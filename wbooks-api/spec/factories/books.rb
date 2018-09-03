FactoryBot.define do
  factory :book do
    genre     { Faker::Book.genre }
    author    { Faker::Book.author }
    image     { Faker::Internet.url }
    title     { Faker::Book.title }
    publisher { Faker::Book.publisher }
    year      { Faker::Date.backward().year }
  end
end
