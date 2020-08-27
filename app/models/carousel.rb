# frozen_string_literal: true

# == Schema Information
#
# Table name: carousels
#
#  id          :bigint           not null, primary key
#  button_text :string
#  button_url  :string
#  image_data  :text             not null
#  position    :integer          default(1), not null
#  region      :integer          not null
#  subtitle    :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_carousels_on_position  (position)
#  index_carousels_on_region    (region)
#

class Carousel < ApplicationRecord
  include CarouselImageUploader::Attachment(:image)

  extend Mobility
  translates :button_text, type: :string
  translates :subtitle,    type: :string
  translates :title,       type: :string

  acts_as_list scope: %i[region]

  enum region: { domestic: 0, foreign: 1 }

  validates :image,    presence: true
  validates :position, presence: true
  validates :region,   presence: true
end
