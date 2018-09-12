FactoryBot.define do
  factory :rent do
    loan            { Faker::Date.backward(5) }
    restitution     { Faker::Date.forward(5) }
    user
    book
  end
end
