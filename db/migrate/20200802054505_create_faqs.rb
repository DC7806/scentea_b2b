# frozen_string_literal: true

class CreateFaqs < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.integer :region, null: false, default: 0
      t.integer :position, null: false, default: 0
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :faqs, :region
    add_index :faqs, %i[category_id position]
    add_index :faqs, %i[category_id title], unique: true, where: "title != ''"
  end
end
