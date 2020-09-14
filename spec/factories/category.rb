# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name_en    { Faker::Lorem.word }
    name_zh_tw { Faker::Lorem.word }

    factory :article_category, class: 'ArticleCategory' do
    end

    factory :faq_category, class: 'FaqCategory' do
    end
  end
end
