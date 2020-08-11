# frozen_string_literal: true

# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  banner_data  :text             not null
#  content      :text             default(""), not null
#  published    :boolean          default(TRUE), not null
#  published_at :datetime         not null
#  region       :integer          default("domestic"), not null
#  slug         :string           not null
#  summary      :text             default(""), not null
#  title        :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#
# Indexes
#
#  index_articles_on_category_id            (category_id)
#  index_articles_on_category_id_and_title  (category_id,title) UNIQUE WHERE ((title)::text <> ''::text)
#  index_articles_on_region                 (region)
#  index_articles_on_slug                   (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
# rubocop:enable Layout/LineLength

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { should belong_to(:category).class_name('ArticleCategory') }
  end

  describe 'validations' do
    subject { create(:article) }

    it { should validate_presence_of(:banner_data) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:content_zh_tw) }
    it { should validate_presence_of(:published_at) }
    it { should validate_presence_of(:region) }
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:summary_zh_tw) }
    it { should validate_presence_of(:title_zh_tw) }
    it { should validate_uniqueness_of(:slug).case_insensitive }
    it { should validate_uniqueness_of(:title).scoped_to(:category_id).case_insensitive }
  end
end
