# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_admin_user!
  layout 'backend'

  protected

    def redirect_to_index
      redirect_to url_for(action: :index)
      flash_success
    end

    def flash_and_render(partial)
      flash_fail
      render partial
    end

  private

    def flash_success
      flash[:notice] = t("actions.#{action_name}") + t('notices.success')
    end

    def flash_fail
      flash.now[:alert] = t("actions.#{action_name}") + t('notices.fail')
    end
end
