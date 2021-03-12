# frozen_string_literal: true

class CreateProductCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :product_categories do |t|
      t.integer :region, null: false
      t.integer :position, null: false, default: 1
      t.string :ancestry
      t.string :name, null: false, default: ''
      t.string :slug, null: false

      t.timestamps
    end

    add_index :product_categories, :ancestry
    add_index :product_categories, :position
    add_index :product_categories, :region
    add_index :product_categories, %i[region ancestry slug],
                                   unique: true
  end
end
