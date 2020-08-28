# frozen_string_literal: true

class AdminController < ApplicationController
  layout 'backend'

  before_action :authenticate_admin_user!
  helper_method :available_regions
  helper_method :current_region

  private

    def redirect_to_index
      paramaters = {}
      paramaters[:action] = :index
      paramaters[:region] = current_region

      flash_success
      redirect_to url_for(paramaters)
    end

    def flash_and_render(partial, record: nil)
      flash.now[:alert] = t('controller.actions.fail')
      flash.now[:error] = record.errors.full_messages if record.present?
      render partial
    end

    def available_regions
      %w[domestic foreign]
    end

    def current_region
      params[:region]
    end

    def current_sort_path
      raise NotImplementedError
    end
end
