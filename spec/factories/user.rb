# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    account
    email      { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    password   { Faker::Internet.password(min_length: 6) }
  end
end
