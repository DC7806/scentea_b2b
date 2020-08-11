# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    category factory: :article_category

    banner_data   { Faker::Lorem.word }
    content_zh_tw { Faker::Lorem.sentence }
    published_at  { Time.zone.now }
    summary_zh_tw { Faker::Lorem.sentence }
    slug          { Faker::Lorem.word }
    title_zh_tw   { Faker::Lorem.word }
  end
end
