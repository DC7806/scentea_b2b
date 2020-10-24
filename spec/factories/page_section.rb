# frozen_string_literal: true

FactoryBot.define do
  factory :page_section do
    page

    content_en { Faker::Lorem.sentence }
    content_zh_tw { Faker::Lorem.sentence }
    style { 0 }
  end
end
