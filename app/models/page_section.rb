# frozen_string_literal: true

# == Schema Information
#
# Table name: page_sections
#
#  id         :bigint           not null, primary key
#  position   :integer          default(0), not null
#  region     :integer          default("domestic"), not null
#  style      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint           not null
#
# Indexes
#
#  index_page_sections_on_page_id   (page_id)
#  index_page_sections_on_position  (position)
#  index_page_sections_on_region    (region)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id) ON DELETE => cascade
#

class PageSection < ApplicationRecord
  acts_as_list scope: %i[page_id region]

  enum region: { domestic: 0, foreign: 1 }

  belongs_to :page

  validates :page,          presence: true
  validates :position,      presence: true
  validates :region,        presence: true
  validates :style,         presence: true
end
