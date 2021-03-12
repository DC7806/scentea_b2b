# frozen_string_literal: true

FactoryBot.define do
  factory :product_category do
    name_en    { Faker::Lorem.word }
    name_zh_tw { Faker::Lorem.word }
    region { %w[domestic foreign].sample }
  end
end
