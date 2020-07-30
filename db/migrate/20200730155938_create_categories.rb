# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :type, null: false
      t.string :name, null: false, default: ''
      t.integer :region, null: false, default: 0
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :categories, :region
    add_index :categories, :position
  end
end
