# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :slug, null: false
      t.string :title, null: false, default: ''
      t.text :banner_data, null: false
      t.text :content, null: false, default: ''
      t.text :summary, null: false, default: ''
      t.integer :region, null: false, default: 0
      t.boolean :published, null: false, default: true
      t.datetime :published_at, null: false
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :articles, :region
    add_index :articles, :slug, unique: true
    add_index :articles, %i[category_id title], unique: true, where: "title != ''"
  end
end
