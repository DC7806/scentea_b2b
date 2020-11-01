# frozen_string_literal: true

class CreateSectionContents < ActiveRecord::Migration[6.0]
  def up
    create_table :section_contents do |t|
      t.string :title ,null: false, default: ''
      t.string :subtitle ,null: false, default: ''
      t.text :description ,null: false, default: ''
      t.string :link_url ,null: false, default: ''
      t.string :link_text ,null: false, default: ''
      t.string :image_data
      t.references :page_section, null: false

      t.timestamps
    end

    add_foreign_key :section_contents, :page_sections, on_delete: :cascade, validate: false
  end

  def down
    drop_table :section_contents
  end
end
