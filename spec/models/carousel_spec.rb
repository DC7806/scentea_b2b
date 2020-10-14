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

require 'rails_helper'

RSpec.describe Carousel, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:region) }
  end
end
