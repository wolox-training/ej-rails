# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

50.times do
  Book.create!(
    author:    Faker::Book.author,
    genre:     Faker::Book.genre,
    image:     Faker::Internet.url,
    title:     Faker::Book.title,
    publisher: Faker::Book.publisher,
    year:      Faker::Date.backward.year
  )
end

user = User.create!(
  email: 'test@mail.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Test',
  last_name: 'Test',
  locale: 'en'
)

user2 = User.create!(
  email: 'test2@mail.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Test 2',
  last_name: 'Test 2',
  locale: 'es'
)

books = Book.all

books.each do |book|
  book.rents.create!(
    user: user,
    loan: Faker::Date.backward(15),
    restitution: Faker::Date.forward(15)
  )

  book.rents.create!(
    user: user2,
    loan: Faker::Date.between(Time.zone.today + 25.days,
      Time.zone.today + 35.days),
    restitution: Faker::Date.between(Time.zone.today + 35.days,
      Time.zone.today + 45.days)
  )
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
AdminUser.create!(email: 'admin2@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
