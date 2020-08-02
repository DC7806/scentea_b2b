# frozen_string_literal: true

module Admin
  module HeaderHelper
    def page_header(resource)
      action_for_resource =
        t("backend.#{action_name}", resource: t("activerecord.models.#{resource}"))
      return action_for_resource unless current_region

      region = t("backend.available_regions.#{current_region}")
      "#{action_for_resource} - #{region}"
    end
  end
end
