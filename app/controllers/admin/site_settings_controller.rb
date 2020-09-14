# frozen_string_literal: true

module Admin
  class SiteSettingsController < AdminController
    before_action :site_setting

    def edit; end

    def update
      if @site_setting.update(site_setting_params)
        flash_success
        redirect_to edit_admin_site_settings_path
      else
        flash_and_render(:edit, record: @site_setting)
      end
    end

    private

      def current_scope
        @current_scope ||= SiteSetting
      end

      def site_setting
        @site_setting ||= current_scope.first
      end

      def site_setting_params
        params.require(:site_setting).permit(
          :customization_form_url_en,
          :customization_form_url_zh_tw,
          :favicon,
          :fb_id,
          :gtm_id,
          :logo,
          :service_email_en,
          :service_email_zh_tw,
          :site_name_en,
          :site_name_zh_tw
        )
      end
  end
end
