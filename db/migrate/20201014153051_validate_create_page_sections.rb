# frozen_string_literal: true

class ValidateCreatePageSections < ActiveRecord::Migration[6.0]
  def change
    validate_foreign_key :page_sections, :pages
  end
end
