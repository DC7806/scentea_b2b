# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    page_name = Faker::Lorem.words(number: 2).join(' ')

    name_en { page_name }
    name_zh_tw { page_name }
    slug { page_name.parameterize }
  end
end
