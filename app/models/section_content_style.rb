# frozen_string_literal: true

class SectionContentStyle < ActiveYaml::Base
  set_root_path Rails.root.join('config', 'active_hash')

  def name
    public_send("name_#{I18n.locale.to_s.underscore}")
  end
end
