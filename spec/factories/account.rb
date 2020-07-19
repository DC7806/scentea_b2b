# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    contact_email { Faker::Internet.email }
    company_name  { Faker::Lorem.word }
    region        { Account.regions.keys.first }
    tax_id_number { Faker::Lorem.word }
  end
end
