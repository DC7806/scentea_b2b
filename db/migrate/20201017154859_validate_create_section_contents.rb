class ValidateCreateSectionContents < ActiveRecord::Migration[6.0]
  def change
    validate_foreign_key :section_contents, :page_sections
  end
end
