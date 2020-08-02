# frozen_string_literal: true

class AddUniqueNameIndexToCategory < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :categories, %i[type region name],
                           unique: true,
                           where: "name != ''",
                           algorithm: :concurrently
  end
end
