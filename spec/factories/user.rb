# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email      { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    password   { Faker::Internet.password(min_length: 6) }

    association :account, :active

    trait :with_created_account do
      association :account, :created
    end

    trait :with_pending_account do
      association :account, :pending
    end
  end
end
