# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    category factory: :article_category

    content_zh_tw { Faker::Lorem.sentence }
    published_at  { Time.zone.now }
    summary_zh_tw { Faker::Lorem.sentence }
    slug          { Faker::Lorem.word }
    title_zh_tw   { Faker::Lorem.word }
    banner do
      Rack::Test::UploadedFile.new(
        'spec/factories/test.jpg', 'image/jpeg'
      )
    end
  end
end
