# frozen_string_literal: true

class CreatePageSections < ActiveRecord::Migration[6.0]
  def up
    create_table :page_sections do |t|
      t.integer :position, null: false, default: 0
      t.integer :region, null: false, default: 0
      t.integer :style, null: false
      t.references :page, null: false

      t.timestamps
    end

    add_index :page_sections, :region
    add_index :page_sections, :position
    add_foreign_key :page_sections, :pages, on_delete: :cascade, validate: false
  end

  def down
    drop_table :page_sections
  end
end
