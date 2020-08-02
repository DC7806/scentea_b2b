# frozen_string_literal: true

# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  position   :integer          default(0), not null
#  region     :integer          default("domestic"), not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_position                  (position)
#  index_categories_on_region                    (region)
#  index_categories_on_type_and_region_and_name  (type,region,name) UNIQUE WHERE ((name)::text <> ''::text)
#
# rubocop:enable Layout/LineLength

class Category < ApplicationRecord
  extend Mobility
  translates :name, type: :string

  acts_as_list scope: %i[type region]

  enum region: { domestic: 0, foreign: 1 }

  validates :name_en,    presence: true
  validates :name_zh_tw, presence: true
  validates :position,   presence: true
  validates :region,     presence: true
  validates :type,       presence: true
  validates :name, uniqueness: { scope: %i[type region], case_sensitive: false }
end
