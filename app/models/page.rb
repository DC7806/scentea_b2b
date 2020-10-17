# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pages_on_slug  (slug) UNIQUE
#

class Page < ApplicationRecord
  extend Mobility
  translates :name, type: :string

  validates :name_en,    presence: true
  validates :name_zh_tw, presence: true
  validates :slug, uniqueness: { case_sensitive: false }
end
