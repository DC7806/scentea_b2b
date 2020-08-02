# frozen_string_literal: true

FactoryBot.define do
  factory :faq do
    category factory: :faq_category

    description_en    { Faker::Lorem.sentence }
    description_zh_tw { Faker::Lorem.sentence }
    title_en          { Faker::Lorem.word }
    title_zh_tw       { Faker::Lorem.word }
  end
end
