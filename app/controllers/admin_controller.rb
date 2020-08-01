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
      paramaters[:region_id] = current_region

      flash_success
      redirect_to url_for(paramaters)
    end

    def flash_and_render(partial)
      flash_fail
      render partial
    end

    def flash_fail
      flash.now[:alert] = t('controller.actions.fail')
    end

    def available_regions
      %w[domestic foreign]
    end

    def current_region
      params[:region_id]
    end

    def current_sort_path
      raise NotImplementedError
    end
end
