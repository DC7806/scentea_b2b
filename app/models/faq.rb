# frozen_string_literal: true

# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: faqs
#
#  id          :bigint           not null, primary key
#  description :text             default(""), not null
#  position    :integer          default(0), not null
#  region      :integer          default("domestic"), not null
#  title       :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_faqs_on_category_id               (category_id)
#  index_faqs_on_category_id_and_position  (category_id,position)
#  index_faqs_on_category_id_and_title     (category_id,title) UNIQUE WHERE ((title)::text <> ''::text)
#  index_faqs_on_region                    (region)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
# rubocop:enable Layout/LineLength

class Faq < ApplicationRecord
  extend Mobility
  translates :title,       type: :string
  translates :description, type: :text

  acts_as_list scope: %i[category_id]

  enum region: { domestic: 0, foreign: 1 }

  belongs_to :category, class_name: 'FaqCategory',
                        inverse_of: :faqs

  validates :category,          presence: true
  validates :description_zh_tw, presence: true
  validates :position,          presence: true
  validates :region,            presence: true
  validates :title_zh_tw,       presence: true
  validates :title, uniqueness: { scope: :category_id, case_sensitive: false }
end
