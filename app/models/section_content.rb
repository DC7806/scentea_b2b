# frozen_string_literal: true

# == Schema Information
#
# Table name: section_contents
#
#  id              :bigint           not null, primary key
#  description     :text             default(""), not null
#  image_data      :string
#  link_text       :string           default(""), not null
#  link_url        :string           default(""), not null
#  subtitle        :string           default(""), not null
#  title           :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  page_section_id :bigint           not null
#
# Indexes
#
#  index_section_contents_on_page_section_id  (page_section_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_section_id => page_sections.id) ON DELETE => cascade
#

class SectionContent < ApplicationRecord
  extend Mobility
  translates :description, type: :text
  translates :link_text,   type: :string
  translates :link_url,    type: :string
  translates :subtitle,    type: :string
  translates :title,       type: :string

  belongs_to :page_section
end
