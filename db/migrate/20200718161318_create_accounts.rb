# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string  :address
      t.string  :brand_name
      t.string  :contact_email, null: false
      t.string  :contact_number
      t.string  :company_name,  null: false, default: ''
      t.integer :region,        null: false, default: 0
      t.integer :status,        null: false, default: 0
      t.string  :tax_id_number

      t.timestamps
    end

    add_index :accounts, :region
    add_index :accounts, :status
  end
end
