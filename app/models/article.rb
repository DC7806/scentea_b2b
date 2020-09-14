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

class Article < ApplicationRecord
  include ArticleBannerUploader::Attachment(:banner)

  extend Mobility
  translates :title,   type: :string
  translates :content, type: :text
  translates :summary, type: :text

  enum region: { domestic: 0, foreign: 1 }

  belongs_to :category, class_name: 'ArticleCategory',
                        inverse_of: :articles

  validates :banner,        presence: true
  validates :category,      presence: true
  validates :content_zh_tw, presence: true
  validates :published_at,  presence: true
  validates :region,        presence: true
  validates :slug,          presence: true
  validates :summary_zh_tw, presence: true
  validates :title_zh_tw,   presence: true
  validates :slug,  uniqueness: { case_sensitive: false }
  validates :title, uniqueness: { scope: :category_id, case_sensitive: false }

  scope :published, -> { where(published: true) }

  ransacker :region, formatter: proc { |v| regions[v] } do |parent|
    parent.table[:region]
  end

  def related_articles
    self.class.published
        .ransack(category_id_eq: category_id, id_not_eq: id)
        .result
  end
end
