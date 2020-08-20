class CreateSiteSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :site_settings do |t|
      t.string :customization_form_url, null: false, default: ''
      t.string :fb_id
      t.string :gtm_id
      t.string :site_name, null: false, default: ''
      t.string :service_email, null: false, default: ''
      t.text :logo_data
      t.text :favicon_data

      t.timestamps
    end
  end
end
