# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout 'frontend'
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up, keys: %i[first_name last_name]
      )
    end

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
      flash[:notice] =
        t("controller.actions.#{action_name}_success",
          resource: current_scope.model_name.human)
    end

    def flash_fail
      flash.now[:alert] = t('controller.actions.fail')
    end

    def current_scope
      raise NotImplementedError
    end
end
