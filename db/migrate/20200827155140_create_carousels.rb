# frozen_string_literal: true

class CreateCarousels < ActiveRecord::Migration[6.0]
  def change
    create_table :carousels do |t|
      t.text :image_data, null: false
      t.string :title
      t.string :subtitle
      t.string :button_text
      t.string :button_url
      t.integer :region, null: false
      t.integer :position, null: false, default: 1

      t.timestamps
    end

    add_index :carousels, :region
    add_index :carousels, :position
  end
end
