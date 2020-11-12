# frozen_string_literal: true

# == Schema Information
#
# Table name: product_categories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  name       :string           default(""), not null
#  position   :integer          default(1), not null
#  region     :integer          not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_categories_on_ancestry                      (ancestry)
#  index_product_categories_on_position                      (position)
#  index_product_categories_on_region                        (region)
#  index_product_categories_on_region_and_ancestry_and_slug  (region,ancestry,slug) UNIQUE
#

class ProductCategory < ApplicationRecord
  extend Mobility
  translates :name, type: :string

  acts_as_list scope: %i[region ancestry]

  before_validation :add_slug

  enum region: { domestic: 0, foreign: 1 }

  validates :name_en,    presence: true
  validates :name_zh_tw, presence: true
  validates :position,   presence: true
  validates :slug,       presence: true
  validates :slug, uniqueness: { scope: %i[region ancestry], case_sensitive: false }

  validates_with LocalizedFieldsUniquenessValidator,
                 fields: %i[name_en name_zh_tw]

  private

    def add_slug
      return unless name_en

      self.slug = name_en.downcase.parameterize
    end
end
